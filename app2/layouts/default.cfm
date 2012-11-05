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
</cfsilent>
<cfoutput>
	<div style="padding:1em 0; margin:2em 0;">
		<div>
			<p>
				<a href="#buildURL('app2:main')#">Public Main</a> 
				| <a href="#buildURL('app2:main.another')#">Another Page</a> 
				| <a href="#buildURL('app2:list')#">List Something</a>
			</p>
		</div>
		<div>
			#body#
		</div>
		<cfif $.currentUser().isSuperUser()>
			<div class="clearfix">
				<a href="#rc.$.globalConfig('context')#/plugins/#rc.pc.getDirectory()#/index.cfm?MuraFW1Action=admin:main.default&compactDisplay=true" rel="shadowbox;">Admin</a>
			</div>
		</cfif>
	</div>
</cfoutput>