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
		local.registrations = rc.registrations;
	</cfscript>
</cfsilent>
<cfoutput>

	<h4>Registrations</h4>

	<cfif len(rc.message)>
		<div class="alert alert-info">
			<a class="close" data-dismiss="alert" href="##">&times;</a>
			#rc.message#
		</div>
	</cfif>

	<table class="table table-striped">
		<thead>
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
			<cfif StructCount(local.registrations) EQ 0>
				<tr>
					<td colspan="3">
						<div class="alert alert-error">
							No registrations exist yet. Would you like to 
							<a href="#buildURL(action='app3:main.form')#">add one now</a>?
						</div>
					</td>
				</tr>
			</cfif>
			<cfloop collection="#local.registrations#" item="local.id">
				<cfset local.registration = local.registrations[local.id]>
				<tr>
					<td>
						<a href="#buildURL(action='app3:main.form&id=#local.id#')#">#local.id#</a>
					</td>
					<td>
						<a href="#buildURL(action='app3:main.form&id=#local.id#')#">#HTMLEditFormat(local.registration.getFName())# #HTMLEditFormat(local.registration.getLName())#</a>
					</td>
					<td>
						<a href="#buildURL(action='app3:main.delete&id=#local.id#')#">[ X ]</a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>

</cfoutput>