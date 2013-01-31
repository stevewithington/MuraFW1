<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2013 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfscript>
		request.layout = true;
	</cfscript>
</cfsilent>
<cfoutput>
	<h4>Main</h4>
	<p>Hello there! Welcome to the <strong>app2:main.default</strong> view.</p>
	<div class="alert alert-success">
		<a class="close" data-dismiss="alert" href="##">&times;</a>
		<p>Here's something from the public services:<br>
		<strong>rc.thisIsJustSomeRCVariable = #rc.thisIsJustSomeRCVariable#</strong></p>
	</div>
</cfoutput>