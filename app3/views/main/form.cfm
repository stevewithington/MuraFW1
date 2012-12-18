<cfsilent>
<!---

This file is part of MuraFW1
Copyright (c) 2010-2012 Stephen J. Withington, Jr.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

	NOTES:

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