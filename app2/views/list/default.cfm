<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfscript>
		request.layout = true;
	</cfscript>
</cfsilent>
<cfoutput>
	<h4>List Something</h4>
	<div class="success">
		<h5>A Few Team Mura Developers:</h5>
		<ul>
			<cfloop list="#rc.something#" index="i">
				<li>#HTMLEditFormat(i)#</li>
			</cfloop>
		</ul>
	</div>

	<!--- Some form testing --->
	<div>
		<form method="post">
			<label for="action">Action</label>
			<!--- NOTE the 'name' attribute! --->
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