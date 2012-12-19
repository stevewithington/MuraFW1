<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:

--->
	<cfscript>
		request.layout = true;
	</cfscript>
</cfsilent>
<cfoutput>

	<div class="alert alert-error error">
		<a class="close" data-dismiss="alert" href="##">&times;</a>
		<cfif StructKeyExists(rc, 'isMissingView') and IsBoolean(rc.isMissingView) and rc.isMissingView>
			<h3>Hmmm&hellip;</h3>
			<p>Apparently, the page you're looking for no longer exists...or, maybe you've been messing with the URL.<br />Either way, you're out of luck.</p>
		<cfelse>
			<h2>Error!</h2>
			<p>We're sorry &hellip; but an unexpected error occurred. You can either <a href="javascript:history.go(-1);">go back and try again</a> or wait and give our Web Response Team some time to figure out what in the heck just happened. It's entirely up to you.</p>
		</cfif>
	</div>

	<cfif IsBoolean(variables.framework.debugMode) and variables.framework.debugMode>
		<div class="alert alert-info">
			<a class="close" data-dismiss="alert" href="##">&times;</a>
			<h2>Debug Output</h2>
			<!--- <cfset local.scopes = 'application,arguments,cgi,client,cookie,form,local,request,server,session,url,variables'> --->
			<cfset local.scopes = 'local,request,session'>
			<cfloop list="#local.scopes#" index="s">
				<cfdump var="#Evaluate(s)#" label="#UCase(s)#" />
			</cfloop>
		</div>
	</cfif>

</cfoutput>