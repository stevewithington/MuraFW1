<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2020 Stephen J. Withington, Jr.
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
			<cfif StructIsEmpty(local.registrations)>
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
						<a href="#buildURL(action='app3:main.form&id=#local.id#')#">#esapiEncode('html', local.registration.getFName())# #esapiEncode('html', local.registration.getLName())#</a>
					</td>
					<td>
						<a href="#buildURL(action='app3:main.delete&id=#local.id#')#">[ X ]</a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>

	<cfif !StructIsEmpty(local.registrations)>
		<p>
			<a class="btn btn-primary" href="#buildURL('app3:main.clear')#">
				Clear All Registrations
			</a>
		</p>
	</cfif>

	<!--- Configurator Settings : Displaying an example of how to retrieve the data --->
	<cfif StructKeyExists(rc, 'app3message')>
		<div class="alert alert-success">
			<a class="close" data-dismiss="alert" href="##">&times;</a>
			<h4>Saved Data From Configurator</h4>
			<cfdump var="#rc.app3message#" label="app3message" />
			<cfdump var="#rc.configuredDTS#" label="configuredDTS" />
			<cfdump var="#rc.configuredBy#" label="configuredBy" />
		</div>
	</cfif>
</cfoutput>
