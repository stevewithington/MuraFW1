/*

This file is part of MuraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

	NOTES: 
		The idea is that you shouldn't have to edit this file.
		See /includes/displayObjects.cfc && /includes/eventHandler.cfc
		on how to access these methods.

*/
component persistent="false" accessors="true" output="false" extends="includes.fw1" {

	include 'includes/fw1config.cfm'; // framework variables
	include '../../config/applicationSettings.cfm';
	include '../../config/mappings.cfm';
	include '../mappings.cfm';

	variables.fw1Keys = 'SERVICEEXECUTIONCOMPLETE,LAYOUTS,CONTROLLEREXECUTIONCOMPLETE,VIEW,SERVICES,CONTROLLERS,CONTROLLEREXECUTIONSTARTED';

	public string function doAction(string action='') {
		var local = {};
		local.targetPath = getPageContext().getRequest().getRequestURI();

		local.action = StructKeyExists(request, variables.framework.action) 
			? request[variables.framework.action] : arguments.action;

		onApplicationStart();

		request.context[variables.framework.action] = StructKeyExists(form, variables.framework.action) 
			? form[variables.framework.action] : StructKeyExists(url, variables.framework.action) 
			? url[variables.framework.action] : local.action;

		request.action = getFullyQualifiedAction(request.context[variables.framework.action]);

		// !important ** DO NOT CHANGE **
		local.cacheID = UCase(arguments.action);

		// The main check here is to see if the subsystem is different...
		// if not, then it should grab the cached state of the application.
		if ( 
			IsNull(CacheGet(local.cacheID)) 
			|| StructKeyExists(request, variables.framework.reload) 
				&& request[variables.framework.reload] == variables.framework.password
			|| getSubSystem(request.action) == getSubSystem(arguments.action)
		) {
			CacheRemove(local.cacheID);
			onRequestStart(local.targetPath);
			savecontent variable='local.response' {
				onRequest(local.targetPath);
			};
			clearFW1Request();
			// should probably make the cache timeout settings dynamic
			CachePut(local.cacheID, local.response, CreateTimeSpan(0,0,5,0), CreateTimeSpan(0,0,5,0));
		};
		return CacheGet(local.cacheID);

	}

	public any function setupApplication() {
		var local = {};
		lock scope="application" type="exclusive" timeout="50" {
			application[variables.framework.applicationKey].pluginConfig = application.pluginManager.getConfig(ID=variables.framework.applicationKey);
			local.pc = application[variables.framework.applicationKey].pluginConfig;
			setBeanFactory(local.pc.getApplication(purge=false));
		};
	}

	public void function setupRequest() {
		var local = {};

		secureRequest();

		request.context.isAdminRequest = isAdminRequest();
		request.context.isFrontEndRequest = isFrontEndRequest();
		
		if ( StructKeyExists(url, application.configBean.getAppReloadKey()) ) { 
			setupApplication();
		};

		if ( !StructKeyExists(request.context, '$') ) {
			request.context.$ = application.serviceFactory.getBean('muraScope');
			if ( StructKeyExists(session, 'siteid') ) {
				request.context.$.init(session.siteid);
			} else {
				request.context.$.init('default');
			};
		};

		request.context.pc = application[variables.framework.applicationKey].pluginConfig;
		request.context.pluginConfig = application[variables.framework.applicationKey].pluginConfig;
		request.context.action = request.context[variables.framework.action];
	}
	
	public void function setupView() {
		var httpRequestData = GetHTTPRequestData();
		if ( 
			StructKeyExists(httpRequestData.headers, 'X-#variables.framework.package#-AJAX') 
			&& IsBoolean(httpRequestData.headers['X-#variables.framework.package#-AJAX']) 
			&& httpRequestData.headers['X-#variables.framework.package#-AJAX'] 
		) {
			setupResponse();
		};
	}
	
	public void function setupResponse() {
		var httpRequestData = GetHTTPRequestData();
		if (
			StructKeyExists(httpRequestData.headers, 'X-#variables.framework.package#-AJAX') 
			&& IsBoolean(httpRequestData.headers['X-#variables.framework.package#-AJAX']) 
			&& httpRequestData.headers['X-#variables.framework.package#-AJAX'] 
		) {
			if ( StructKeyExists(request.context, 'fw') ) {
				StructDelete(request.context, 'fw');
			}
			if ( StructKeyExists(request.context, '$') ) {
				StructDelete(request.context, '$');
			}
			WriteOutput( SerializeJSON(request.context) );
			abort;
		};
	}

	public string function buildURL(required string action, string path='#variables.framework.baseURL#', string queryString='') {
		var regx = '&?compactDisplay=[true|false]';
		arguments.action = getFullyQualifiedAction(arguments.action);
		if (
			StructKeyExists(request.context, 'compactDisplay') 
			&& IsBoolean(request.context.compactDisplay) 
			&& !REFindNoCase(regx, arguments.action) 
			&& !REFindNoCase(regx, arguments.queryString) 
		) {
			var qs = 'compactDisplay=' & request.context.compactDisplay;
			if ( !Find('?', arguments.action) ) {
				arguments.queryString = ListAppend(arguments.queryString, qs, '&');
			} else {
				arguments.action = ListAppend(arguments.action, qs, '&');
			};
		};
		return super.buildURL(argumentCollection=arguments);
	}

	
	// ========================== Errors & Missing Views ==============================

	public any function onError() output="true" {
		//var scopes = 'application,arguments,cgi,client,cookie,form,local,request,server,session,url,variables';
		var scopes = 'local,request,session';
		var arrScopes = ListToArray(scopes);
		var i = '';
		var scope = '';
		WriteOutput('<h2>' & variables.framework.package & ' ERROR</h2>');
		if ( IsBoolean(variables.framework.debugMode) && variables.framework.debugMode ) {
			for ( i=1; i <= ArrayLen(arrScopes); i++ ) {
				scope = arrScopes[i];
				WriteDump(var=Evaluate(scope),label=UCase(scope));
			};
		};
		abort;
	}

	public any function onMissingView(any rc) {
		rc.errors = [];
		rc.isMissingView = true;
		// forward to appropriate error screen
		if ( isFrontEndRequest() ) {
			ArrayAppend(rc.errors, "The page you're looking for doesn't exist.");
			redirect(action='public:main.error', preserve='errors,isMissingView');
		} else {
			ArrayAppend(rc.errors, "The page you're looking for <strong>#rc.action#</strong> doesn't exist.");
			redirect(action='admin:main', preserve='errors,isMissingView');
		};
	}

	// ========================== Helper Methods ==============================

	public any function secureRequest() {
		if ( isAdminRequest() && !( IsDefined('session.mura') && ListFindNoCase(session.mura.memberships,'S2') ) ) {
			if ( !StructKeyExists(session,'siteID') || !application.permUtility.getModulePerm(application[variables.framework.applicationKey].pluginConfig.getModuleID(),session.siteid) ) {
				location(url='#application.configBean.getContext()#/admin/', addtoken=false);
			};
		};
	}

	public boolean function isAdminRequest() {
		if ( StructKeyExists(request, 'context') && ListFirst(request.context[variables.framework.action], ':') == 'admin' ) {
			return true;
		} else {
			return false;
		};
	}

	public boolean function isFrontEndRequest() {
		return StructKeyExists(request, 'murascope');
	}

	// ==========================  STATE  ==============================

	public void function clearFW1Request() {
		var arrFW1Keys = ListToArray(variables.fw1Keys);
		var i = '';
		if ( StructKeyExists(request, '_fw1') ) {
			for ( i=1; i <= ArrayLen(arrFW1Keys); i++ ) {
				StructDelete(request._fw1, arrFW1Keys[i]);
			};
			request._fw1.requestDefaultsInitialized = false;
		};
	}

}