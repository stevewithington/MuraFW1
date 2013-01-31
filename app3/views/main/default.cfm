<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2013 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

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