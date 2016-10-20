<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2016 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
<cfif not StructKeyExists(request, 'mfw1cssexists') or not request.mfw1cssexists>
  <cfset pluginPath =
    rc.$.globalConfig('context')
    & '/plugins/'
    & rc.pluginConfig.getPackage() />
	<cfsavecontent variable="htmlhead"><cfoutput><link rel="stylesheet" type="text/css" href="#pluginPath#/includes/assets/css/murafw1.css"></cfoutput></cfsavecontent>
	<cfhtmlhead text="#htmlhead#" />
	<cfset request.mfw1cssexists = true>
</cfif>
</cfsilent>
<cfoutput>#body#</cfoutput>
