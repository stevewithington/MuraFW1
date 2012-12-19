<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfsavecontent variable="htmlhead"><cfoutput>
		<link rel="stylesheet" type="text/css" href="#$.event('pluginPath')#includes/assets/css/murafw1.css">
	</cfoutput></cfsavecontent>
	<cfhtmlhead text="#htmlhead#" />
</cfsilent>
<cfoutput>#body#</cfoutput>