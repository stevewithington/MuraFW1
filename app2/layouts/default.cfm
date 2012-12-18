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
		<h3>Application ##2</h3>
		<div>
			<ul class="nav nav-pills">
				<li<cfif rc.action eq 'app2:main.default'> class="active"</cfif>>
					<a href="#buildURL('app2:main')#">Application ##2 Main</a>
				</li>
				<li<cfif rc.action eq 'app2:main.another'> class="active"</cfif>>
					<a href="#buildURL('app2:main.another')#">Another Page</a>
				</li>
				<li<cfif rc.action eq 'app2:list.default'> class="active"</cfif>>
					<a href="#buildURL('app2:list')#">List Something</a>
				</li>
			</ul>
		</div>
		<div>#body#</div>
		<cfif $.currentUser().isSuperUser()>
			<div class="clearfix">
				<a href="#rc.$.globalConfig('context')#/plugins/#rc.pc.getDirectory()#/index.cfm?MuraFW1Action=admin:main.default&compactDisplay=true" rel="shadowbox;">Admin</a>
			</div>
		</cfif>
	</div>
</cfoutput>