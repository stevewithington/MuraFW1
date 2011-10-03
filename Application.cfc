<!---

This file is part of muraFW1
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

		Document:	Application.cfc
		Author:		Steve Withington | www.stephenwithington.com

--->
<cfcomponent extends="fw1">

	<cfinclude template="../../config/applicationSettings.cfm" />
	<cfinclude template="../../config/mappings.cfm" />
	<cfinclude template="../mappings.cfm" />
	<cfset variables.framework = getFramework() />

	<!--- ********************** fw/1-specific *************************** --->
	<cffunction name="setupApplication" output="false">
		<cfscript>
			var local = StructNew();
		</cfscript>
		<cflock type="exclusive" timeout="50">
			<cfscript>
				// THIS IS CRITICIAL!! This is what gives this FW/1 app access to it's own pluginConfig within Mura CMS
				// in the setupRequest() it is also assigned to request.context to allow you to access the pluginConfig with 'rc.pc' OR 'rc.pluginConfig'
				application[variables.framework.applicationKey].pluginConfig = application.pluginManager.getConfig(ID=variables.framework.applicationKey);
				local.pc = application[variables.framework.applicationKey].pluginConfig;
				setBeanFactory(local.pc.getApplication(purge=false));
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="setupRequest">
		<cfscript>
			var local = StructNew();

			secureRequest();
			request.context.isAdminRequest = isAdminRequest();
			request.context.isFrontEndRequest = isFrontEndRequest();
			
			if ( StructKeyExists(url, application.configBean.getAppReloadKey()) ) { 
				setupApplication();
			};

			// rc.$
			if ( not StructKeyExists(request.context, '$') and StructKeyExists(session, 'siteid') ) {
				request.context.$ = getBeanFactory().getBean('muraScope').init(session.siteid);
			};

			// rc.pc and rc.pluginConfig
			request.context.pc = application[variables.framework.applicationKey].pluginConfig;
			request.context.pluginConfig = application[variables.framework.applicationKey].pluginConfig;
			
			request.context.action = request.context[variables.framework.action];
		</cfscript>
	</cffunction>

	<cffunction name="onMissingView" output="true">
		<cfargument name="rc" />
		<cfscript>
			var local = StructNew();			
			local.eMessage = "The page you're looking for ";
			// rc.action SHOULD always be there, but just in case...
			if ( StructKeyExists(arguments.rc, 'action') ) {
				local.eMessage = local.eMessage & '<em>' & rc.action & '</em> ';
			};
			local.eMessage = local.eMessage & " doesn't exist.";
			
			rc.errors = ArrayNew(1);
			ArrayAppend(rc.errors, local.eMessage);
			
			// forward to appropriate error screen
			if ( isFrontEndRequest() ) {
				redirect(action='public:main.error',preserve='errors');
			} else {
				redirect(action='admin:main.error',preserve='errors');
			};
		</cfscript>
	</cffunction>

	<!--- this should only be used for dev --->
	<cffunction name="onError" output="true">
		<cfdump var="#arguments#" label="arguments" />
		<cfdump var="#request#" label="request" />
		<cfabort />
	</cffunction>

	<!--- ********************** HELPERS / Mura-specific *************************** --->
	<cffunction name="secureRequest" output="false">
		<cfif isAdminRequest() and not ( isDefined('session.mura') and listFindNoCase(session.mura.memberships,'S2') )>
			<cfif not StructKeyExists(session,'siteID') or not application.permUtility.getModulePerm(getBeanFactory('pluginConfig').getValue('moduleID'),session.siteid)>
				<cflocation url="#application.configBean.getContext()#/admin/" addtoken="false" />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="isAdminRequest" output="false" returntype="boolean">
		<cfscript>
			//if ( StructKeyExists(request, 'action') and ListFirst(request.action, ':') eq 'admin' ) {
			if ( StructKeyExists(request, variables.framework.action) and ListFirst(request[variables.framework.action], ':') eq 'admin' ) {
				return true;
			} else {
				return false;
			};
		</cfscript>
	</cffunction>

	<cffunction name="isFrontEndRequest" output="false" returntype="boolean">
		<cfreturn StructKeyExists(request, 'murascope') />
	</cffunction>

	<!--- apparently needed for CF8 (thanks Grant Shepert!) --->
	<cffunction name="getFramework" output="false" returntype="any">
		<cfset var framework = StructNew() />
		<cfinclude template="fw1config.cfm" />
		<cfreturn framework />
	</cffunction>

	<cffunction name="buildURL" access="public" output="false" hint="Appends compatDisplay to query string if the current template is in compactDisplay mode.">
		<cfargument name="action" type="string" />
		<cfargument name="path" type="string" default="#variables.framework.baseURL#" />
		<cfargument name="queryString" type="string" default="" />
		
		<cfif StructKeyExists(request.context, "compactDisplay") 
			and IsBoolean(request.context.compactDisplay)
			and not REFindNoCase('&?compactDisplay=[true|false]',arguments.action)
			and not REFindNoCase('&?compactDisplay=[true|false]',arguments.queryString)>
				
			<cfif not find('?',arguments.action)>
				<cfset arguments.queryString = ListAppend(arguments.queryString,"compactDisplay=#request.context.compactDisplay#","&") />
			<cfelse>
				<cfset arguments.action = ListAppend(arguments.action, "compactDisplay=#request.context.compactDisplay#","&") />				
			</cfif>			
			
		</cfif>
		
		<cfreturn super.buildURL(argumentCollection=arguments)/>
		
	</cffunction>

</cfcomponent>