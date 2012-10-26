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

--->
	<cfscript>
		// set to false if you don't want to inherit the default layout
		//request.layout = false;
	</cfscript>
</cfsilent>
<cfoutput>
	<h3>List Something</h3>
	<div class="success">
		<h5>A Few Team Mura Developers:</h5>
		<ul>
			<cfloop list="#rc.something#" index="i">
				<li>#HTMLEditFormat(i)#</li>
			</cfloop>
		</ul>
	</div>

	<!--- Just testing --->
	<div>
		<form method="post">
			<label for="action">Action</label>
			<select id="action" name="MuraFW1Action">
				<cfset local.actions = 'app2:main.default,app2:main.another,app2:list.default'>
				<cfloop list="#local.actions#" index="local.i">
					<option value="#local.i#"<cfif rc.action eq local.i> selected="selected"</cfif>>#local.i#</option>
				</cfloop>
			</select>
			<input type="submit" value="Submit" />
		</form>
	</div>
</cfoutput>