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