<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2020 Stephen J. Withington, Jr.
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
		<p>Here's something from the sample service:<br>
		<strong>rc.thisIsJustSomeRCVariable = #rc.thisIsJustSomeRCVariable#</strong></p>
	</div>

	<div class="alert alert-info">
		<p><strong>Note:</strong><br />
		If <em>variables.framework.siloSubsystems=<strong>true</strong></em>, then clicking the button below should not change the view of this display object. If set to <em><strong>false</strong></em>, then clicking the button below should update all MuraFW1 display objects to the requested view. If you have the <strong>MuraFW1 App3</strong> display object assigned to this page, it should update regardless.</p>

		<p>The current setting is: <strong>#variables.framework.siloSubsystems#</strong>

		<p><a class="btn btn-danger" href="#buildURL('app3:main.form')#">app3:main.form</a></p>
	</div>
</cfoutput>
