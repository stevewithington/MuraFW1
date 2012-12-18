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
</cfsilent>
<cfoutput>
	<div class="row-fluid">
		<h3>Application ##3</h3>
		<div>
			<ul class="nav nav-pills">
				<li<cfif rc.action eq 'app3:main.default'> class="active"</cfif>>
					<a href="#buildURL('app3:main')#">Registrations</a>
				</li>
				<li<cfif rc.action eq 'app3:main.form'> class="active"</cfif>>
					<a href="#buildURL('app3:main.form')#">Add Registration</a>
				</li>
				<li<cfif rc.action eq 'app3:main.clear'> class="active"</cfif>>
					<a href="#buildURL('app3:main.clear')#">Clear All Registrations</a>
				</li>
			</ul>
		</div>
		<div>#body#</div>
		<cfif $.currentUser().isSuperUser()>
			<div>
				<a href="#rc.$.globalConfig('context')#/plugins/#rc.pc.getDirectory()#/index.cfm?#variables.framework.action#=admin:main.default&compactDisplay=true" rel="shadowbox;">Admin</a>
			</div>
		</cfif>

	</div>
</cfoutput>