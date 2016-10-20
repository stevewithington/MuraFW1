/*

This file is part of MuraFW1

Copyright 2010-2016 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		Edit the setSessionCache() method to alter the 'expires' key.
		Defaults to 1 hour. The sessionCache will also expire
		if the application has been reloaded.

*/
component persistent="false" accessors="true" output="false" extends="framework.one" {

	include 'config.fw1.cfm'; // framework variables
	include '../../config/applicationSettings.cfm';
	include '../../config/mappings.cfm';
	include '../mappings.cfm';

	variables.fw1Keys = 'SERVICEEXECUTIONCOMPLETE,LAYOUTS,CONTROLLEREXECUTIONCOMPLETE,VIEW,SERVICES,CONTROLLERS,CONTROLLEREXECUTIONSTARTED';

	public string function doAction(string action='') {
		var p = variables.framework.package;
		var fwa = variables.framework.action;
		var local = {};

		clearFW1Request();

		local.targetPath = getPageContext().getRequest().getRequestURI();

		setupFrameworkDefaults();
		setupRequestDefaults();

		if ( !isFrameworkInitialized() || isFrameworkReloadRequest() ) {
			setupApplicationWrapper();
		}

		restoreFlashContext();

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

		local.response = variables.framework.siloSubsystems
			? getCachedView(local.viewKey) : '';

		local.newViewRequired = !Len(local.response)
			? true : getSubSystem(arguments.action) == getSubSystem(request.context[fwa])
			? true : false;

		if ( local.newViewRequired ) {
			onRequestStart(local.targetPath);
			savecontent variable='local.response' {
				onRequest(local.targetPath);
			};
			clearFW1Request();

			if ( variables.framework.siloSubsystems ) {
				setCachedView(local.viewKey, local.response);
			}
		}

		return local.response;
	}

	// exposed for use by model.handlers.murafw1.cfc:onApplicationLoad()
	public void function setupApplicationWrapper() {
		lock scope='application' type='exclusive' timeout=20 {
			super.setupApplicationWrapper();
		};
	}

	public void function setupApplication() {
		var local = {};

		if ( !StructKeyExists(application, 'pluginManager') ) {
			location(url='/', addtoken=false);
		}

		lock scope='application' type='exclusive' timeout=20 {
			getFw1App().pluginConfig = application.pluginManager.getConfig(ID=variables.framework.applicationKey);
		};
	}

	public void function setupRequest() {
		var local = {};

		param name='request.context.siteid' default='';

		if ( !StructKeyExists(session, 'siteid') ) {
			lock scope='session' type='exclusive' timeout='10' {
				session.siteid = 'default';
			};
		}

		secureRequest();

		request.context.isAdminRequest = isAdminRequest();
		request.context.isFrontEndRequest = isFrontEndRequest();

		if ( StructKeyExists(url, application.configBean.getAppReloadKey()) ) {
			setupApplication();
			//setupApplicationWrapper();
		}

		if ( Len(Trim(request.context.siteid)) && ( session.siteid != request.context.siteid) ) {
			local.siteCheck = application.settingsManager.getSites();
			if ( StructKeyExists(local.siteCheck, request.context.siteid) ) {
				lock scope='session' type='exclusive' timeout='10' {
					session.siteid = request.context.siteid;
				};
			};
		}

		if ( !StructKeyExists(request.context, '$') ) {
			request.context.$ = StructKeyExists(request, 'muraScope') ? request.muraScope : application.serviceFactory.getBean('muraScope').init(session.siteid);
		}

		if ( !StructKeyExists(request.context, 'm') ) {
			request.context.m = request.context.$;
		}

		request.context.pc = getFw1App().pluginConfig;
		request.context.pluginConfig = getFw1App().pluginConfig;
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
		}
	}

	public void function setupResponse() {
		var httpRequestData = GetHTTPRequestData();
		if (
			StructKeyExists(httpRequestData.headers, 'X-#variables.framework.package#-AJAX')
			&& IsBoolean(httpRequestData.headers['X-#variables.framework.package#-AJAX'])
			&& httpRequestData.headers['X-#variables.framework.package#-AJAX']
		) {
			StructDelete(request.context, 'fw');
			StructDelete(request.context, '$');
			StructDelete(request.context, 'm');
			WriteOutput(SerializeJSON(request.context));
			abort;
		}
	}

	public void function setupSession() {
		include '../../config/appcfc/onSessionStart_include.cfm';
	}

	public void function onSessionEnd() {
		include '../../config/appcfc/onSessionEnd_include.cfm';
	}

	public string function buildURL(required string action, string path='#resolvePath()#', any queryString='') {
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
				if ( isSimpleValue(arguments.queryString) ) {
					arguments.queryString = ListAppend(arguments.queryString, qs, '&');
				} else if ( isStruct(arguments.queryString) ) {
					structAppend(arguments.queryString, {"compactDisplay"=request.context.compactDisplay} );
				}
			} else {
				arguments.action = ListAppend(arguments.action, qs, '&');
			}
		}

		return super.buildURL(argumentCollection=arguments);
	}

	public string function redirect(required string action, string preserve='none', string append='none', string path='#resolvePath()#', string queryString='', string statusCode='302') {
		return super.redirect(argumentCollection=arguments);
	}

	public any function resolvePath(string path='#variables.framework.baseURL#') {
		// don't modify a submitted path
		if ( arguments.path != variables.framework.baseURL ) {
			return arguments.path;
		}

		var uri =  getPageContext().getRequest().getRequestURI();

		// if displayed as a display object, we could be accessing via the JSON API
		if ( ListFindNoCase(uri, '_api', '/') ) {
			return './';
		}

		var arrURI = ListToArray(uri, '/');
		var indexPos = ArrayFind(arrURI, 'index.cfm');
		var useIndex = YesNoFormat(application.configBean.getValue('indexfileinurls'));
		var useSiteID = YesNoFormat(application.configBean.getValue('siteidinurls'));

		if ( !useIndex && indexPos ) {
			ArrayDeleteAt(arrURI, indexPos);
			uri = ArrayLen(arrURI)
				? '/' & ArrayToList(arrURI, '/') & '/'
				: '/';
		}

		return uri;
	}

	public any function isFrameworkInitialized() {
		return super.isFrameworkInitialized() && StructKeyExists(getFw1App(), 'cache');
	}

	// ========================== Errors & Missing Views ==========================

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
			}
			abort;
		}

		// public any function onMissingView(any rc) {
		// 	rc.errors = [];
		// 	rc.isMissingView = true;
		// 	// forward to appropriate error screen
		// 	if ( isFrontEndRequest() ) {
		// 		ArrayAppend(rc.errors, "The page you're looking for doesn't exist.");
		// 		redirect(action='app1:main.error', preserve='errors,isMissingView');
		// 	} else {
		// 		ArrayAppend(rc.errors, "The page you're looking for <strong>#rc.action#</strong> doesn't exist.");
		// 		redirect(action='admin:main', preserve='errors,isMissingView');
		// 	}
		// }

	// ========================== Helper Methods ==================================

		public any function secureRequest() {
			return !isAdminRequest() || (StructKeyExists(session, 'mura') && ListFindNoCase(session.mura.memberships,'S2')) ? true :
					!StructKeyExists(session, 'mura')
					|| !StructKeyExists(session, 'siteid')
					|| !application.permUtility.getModulePerm(getFw1App().pluginConfig.getModuleID(), session.siteid)
						? goToLogin() : true;
		}

		private void function goToLogin() {
			location(url='#application.configBean.getContext()#/admin/index.cfm?muraAction=clogin.main&returnURL=#application.configBean.getContext()#/plugins/#variables.framework.package#/', addtoken=false);
		}

		public boolean function isAdminRequest() {
			return StructKeyExists(request, 'context') && ListFirst(request.context[variables.framework.action], ':') == 'admin' ? true : false;
		}

		public boolean function isFrontEndRequest() {
			return StructKeyExists(request, 'murascope');
		}

	// ========================== STATE ===========================================

		public void function clearFW1Request() {
			var arrFW1Keys = ListToArray(variables.fw1Keys);
			var i = '';
			if ( StructKeyExists(request, '_fw1') ) {
				for ( i=1; i <= ArrayLen(arrFW1Keys); i++ ) {
					StructDelete(request._fw1, arrFW1Keys[i]);
				}
			}
			request._fw1 = {
				cgiScriptName = CGI.SCRIPT_NAME
				, cgiPathInfo = CGI.PATH_INFO
				, cgiRequestMethod = CGI.REQUEST_METHOD
				, controllers = []
				, requestDefaultsInitialized = false
				, services = []
				, doTrace = variables.framework.trace
				, trace = []
			};
		}

	// ========================== PRIVATE =========================================

		private any function getCachedView(required string viewKey) {
			var view = '';
			var cache = getSessionCache();
			if ( StructKeyExists(cache, 'views') && StructKeyExists(cache.views, arguments.viewKey) ) {
				view = cache.views[arguments.viewKey];
			}
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
			}
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
