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
	</cfscript>
</cfsilent>
<cfoutput>
	<h3>Application ##1: Registration</h3>

	<cfif rc.isSubmitted>
		<h4>Sample Form Has Been Submitted!</h4>
		<cfdump var="#form#" label="FORM" />
		<cfdump var="#rc#" label="REQUEST.CONTEXT" />
	<cfelse>
		<h4>Sample Form</h4>
		<form method="post">
			<p>
				<label for="fname">First Name</label>
				<input type="text" name="fname" value="#rc.fname#" />
			</p>
			<p>
				<label for="lname">Last Name</label>
				<input type="text" name="lname" value="#rc.lname#" />
			</p>
			<input type="hidden" name="MuraFW1Action" value="public:registration.default" />
			<input type="hidden" name="isSubmitted" value="true" />
			<p><input type="submit" value="Submit" /></p>
		</form>
	</cfif>

</cfoutput>