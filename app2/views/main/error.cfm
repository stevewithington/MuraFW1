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
		request.layout = true;
	</cfscript>
</cfsilent>
<cfoutput>

	<div class="alert alert-error error">
		<cfif StructKeyExists(rc, 'isMissingView') and IsBoolean(rc.isMissingView) and rc.isMissingView>
			<h3>Hmmm&hellip;</h3>
			<p>Apparently, the page you're looking for no longer exists...or, maybe you've been messing with the URL.<br />Either way, you're out of luck.</p>
		<cfelse>
			<h2>Error!</h2>
			<p>We're sorry &hellip; but an unexpected error occurred. You can either <a href="javascript:history.go(-1);">go back and try again</a> or wait and give our Web Response Team some time to figure out what in the heck just happened. It's entirely up to you.</p>
		</cfif>
	</div>

	<cfif IsBoolean(variables.framework.debugMode) and variables.framework.debugMode>
		<h2>Debug Output</h2>
		<!--- <cfset local.scopes = 'application,arguments,cgi,client,cookie,form,local,request,server,session,url,variables'> --->
		<cfset local.scopes = 'local,request,session'>
		<cfloop list="#local.scopes#" index="s">
			<cfdump var="#Evaluate(s)#" label="#UCase(s)#" />
		</cfloop>
	</cfif>

</cfoutput>