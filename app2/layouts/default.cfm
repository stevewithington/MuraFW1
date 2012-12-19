<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

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