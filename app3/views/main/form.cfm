<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2016 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfscript>
		//request.layout = false;
		local.registration = rc.registration;
	</cfscript>
</cfsilent>
<cfoutput>
	<div class="row">
		<div class="col-md-6">
			<h4>Add Registration</h4>
			<form role="form" method="post">
				<div class="form-group">
					<label for="fname">First Name</label>
					<input type="text" class="form-control" name="fname" value="#esapiEncode('html_attr', local.registration.getFName())#" />
				</div>
				<div class="form-group">
					<label for="lname">Last Name</label>
					<input type="text" class="form-control" name="lname" value="#esapiEncode('html_attr', local.registration.getLName())#" />
				</div>
				<input type="hidden" name="#variables.framework.action#" value="#getFullyQualifiedAction('app3:main.save')#" />
				<input type="hidden" name="id" value="#local.registration.getID()#" />
				<button type="submit" class="btn btn-default" value="Save Registration">Submit</button>
			</form>
		</div>
	</div>
</cfoutput>
