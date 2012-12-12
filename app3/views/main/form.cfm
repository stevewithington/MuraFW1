<cfsilent>
<!---

This file is part of MuraFW1
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