<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfscript>
		//request.layout = false;
		local.registration = rc.registration;
	</cfscript>
</cfsilent>
<cfoutput>
	<h4>Add Registration</h4>
	<form method="post">
		<div class="field">
			<label for="fname">First Name</label>
			<input type="text" name="fname" value="#HTMLEditFormat(local.registration.getFName())#" />
		</div>
		<div class="field">
			<label for="lname">Last Name</label>
			<input type="text" name="lname" value="#HTMLEditFormat(local.registration.getLName())#" />
		</div>
		<input type="hidden" name="#variables.framework.action#" value="#getFullyQualifiedAction('app3:main.save')#" />
		<input type="hidden" name="id" value="#local.registration.getID()#" />
		<div class="control">
			<input type="submit" value="Save Registration" />
		</div>
	</form>
</cfoutput>