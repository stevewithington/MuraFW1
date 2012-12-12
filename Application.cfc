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
		Edit the setSessionCache() method to alter the 'expires' key.
		Defaults to 1 hour. The sessionCache will also expire
		if the application has been reloaded.

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
		var p = variables.framework.package; 
		var fwa = variables.framework.action;
		var local = {};

		local.targetPath = getPageContext().getRequest().getRequestURI();
		onApplicationStart();

		request.context[fwa] = StructKeyExists(form, fwa) 
			? form[fwa] : StructKeyExists(url, fwa) 
			? url[fwa] : StructKeyExists(request, fwa)
			? request[fwa] : getFullyQualifiedAction(arguments.action);

		request.action = getFullyQualifiedAction(request.context[fwa]);

		// viewKey: package_subsystem_section_item
		local.viewKey = UCase(
			p 
			& '_' & getSubSystem(arguments.action) 
			& '_' & getSection(arguments.action)
			& '_' & getItem(arguments.action)
		);

		local.response = getCachedView(local.viewKey);

		local.newViewRequired = !Len(local.response) 
			? true : getSubSystem(arguments.action) == getSubSystem(request.context[fwa])
			? true : false;

		if ( local.newViewRequired ) {
			onRequestStart(local.targetPath);
			savecontent variable='local.response' {
				onRequest(local.targetPath);
			};
			clearFW1Request();
			setCachedView(local.viewKey, local.response);
		};

		return local.response;
	}

	public any function setupApplication() {
		var local = {};

		lock scope='application' type='exclusive' timeout=50 {
			application[variables.framework.applicationKey].pluginConfig = application.pluginManager.getConfig(ID=variables.framework.applicationKey);
		};

		// Bean Factory Options

		// 1) Use DI/1
		// just be sure to pass in your comma-separated list of folders to scan for CFCs
		//local.beanFactory = new includes.ioc('/plugins/MuraFW1/app2/services,/plugins/MuraFW1/public/model');
		local.beanFactory = new includes.factory.ioc('/#variables.framework.package#/app2/services,/#variables.framework.package#/app3/model');
		setBeanFactory( local.beanFactory );

		// OR

		// 2) Use Mura's
		// local.pc = application[variables.framework.applicationKey].pluginConfig;
		// setBeanFactory(local.pc.getApplication(purge=false));
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
		return StructKeyExists(request, 'context') && ListFirst(request.context[variables.framework.action], ':') == 'admin' ? true : false;
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

	// ========================== PRIVATE ==============================

	private any function getCachedView(required string viewKey) {
		var view = '';
		var cache = getSessionCache();
		if ( StructKeyExists(cache, 'views') && StructKeyExists(cache.views, arguments.viewKey) ) {
			view = cache.views[arguments.viewKey];
		};
		return view;
	}

	private void function setCachedView(required string viewKey, string viewValue='') {
		lock scope='session' type='exclusive' timeout=10 {
			session[variables.framework.package].views[arguments.viewKey] = arguments.viewValue;
		};
	}

	private boolean function isCacheExpired() {
		var p = variables.framework.package;
		return !StructKeyExists(session, p) 
				|| DateCompare(now(), session[p].expires, 's') == 1 
				|| DateCompare(application.appInitializedTime, session[p].created, 's') == 1
			? true : false;
	}

	private any function getSessionCache() {
		var local = {};
		if ( isCacheExpired() ) {
			setSessionCache();
		};
		lock scope='session' type='readonly' timeout=10 {
			local.cache = session[variables.framework.package];
		};
		return local.cache;
	}

	private void function setSessionCache() {
		var p = variables.framework.package;
		// Expires - s:seconds, n:minutes, h:hours, d:days
		lock scope='session' type='exclusive' timeout=10 {
			StructDelete(session, p);
			session[p] = {
				created = Now()
				, expires = DateAdd('h', 1, Now())
				, sessionid = Hash(CreateUUID())
				, views = {}
			};
		};
	}

}
