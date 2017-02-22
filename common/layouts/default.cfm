<cfsilent>
<cfscript>
/**
*
* This file is part of MuraFW1
*
* Copyright 2010-2017 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
</cfscript>
<cfsavecontent variable="local.errors">
  <cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
    <div class="alert alert-error">
      <button type="button" class="close" data-dismiss="alert"><i class="icon-remove-sign"></i></button>
      <h2>Alert!</h2>
      <h3>Please note the following message<cfif ArrayLen(rc.errors) gt 1>s</cfif>:</h3>
      <ul>
        <cfloop from="1" to="#ArrayLen(rc.errors)#" index="local.e">
          <li>
            <cfif IsSimpleValue(rc.errors[local.e])>
              <cfoutput>#rc.errors[local.e]#</cfoutput>
            <cfelse>
              <cfdump var="#rc.errors[local.e]#" />
            </cfif>
          </li>
        </cfloop>
      </ul>
    </div><!--- /.alert --->
  </cfif>
</cfsavecontent>
</cfsilent>
<cfscript>
	param name="rc.compactDisplay" default="false";
  body = local.errors & body;
</cfscript>
<cfoutput>

  <cfif StructKeyExists(rc, 'isfrontendrequest') and rc.isfrontendrequest>
    #body#
  <cfelse>
    #application.pluginManager.renderAdminTemplate(
  		body=body
  		,pageTitle=rc.pc.getName()
  		,compactDisplay=rc.compactDisplay
  	)#
  </cfif>

  <script>
    Mura(function(m) { 
      m.loader() 
        .loadcss('#rc.m.globalConfig('context')#/plugins/MuraFW1/assets/css/murafw1.css') ;
    });
  </script>
</cfoutput>
