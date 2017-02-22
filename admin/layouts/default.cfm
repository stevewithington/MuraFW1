<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2017 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfsavecontent variable="local.errors">
		<cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
			<div class="alert alert-error">
				<button type="button" class="close" data-dismiss="alert"><i class="icon-remove-sign"></i></button>
				<h2>Alert!</h2>
				<h3>Please note the following message<cfif ArrayLen(rc.errors) gt 1>s</cfif>:</h3>
				<ul>
					<cfloop from="1" to="#ArrayLen(rc.errors)#" index="local.e">
						<li>
							<cfif IsSimpleValue(rc.errors[local.e])>
								<cfoutput>#rc.errors[local.e]#</cfoutput>
							<cfelse>
								<cfdump var="#rc.errors[local.e]#" />
							</cfif>
						</li>
					</cfloop>
				</ul>
			</div><!--- /.alert --->
		</cfif>
	</cfsavecontent>
	<cfscript>
		param name="rc.compactDisplay" default="false";
		body = local.errors & body;
	</cfscript>
</cfsilent>
<cfsavecontent variable="local.newBody">
	<cfoutput>
		<div class="container-murafw1 container">

			<!--- PRIMARY NAV --->
			<div class="row">
				<div class="col-md-12">
					<div class="navbar navbar-murafw1">
						<div class="navbar-header">
							<a class="plugin-brand" href="#buildURL('admin:main')#">
								#esapiEncode('html', rc.pc.getPackage())#
							</a>
						</div><!--- /.navbar-header --->

						<ul class="nav navbar-nav">
							<li class="<cfif rc.action contains 'admin:main'>active</cfif>">
								<a href="##" class="dropdown-toggle" data-toggle="dropdown">Main <b class="caret"></b></a>
								<ul class="dropdown-menu">
									<li class="<cfif rc.action eq 'admin:main.default'>active</cfif>">
										<a href="#buildURL('admin:main')#"><i class="icon-home"></i> Home</a>
									</li>
									<li class="<cfif rc.action contains 'admin:main.another'>active</cfif>">
										<a href="#buildURL('admin:main.another')#"><i class="icon-leaf"></i> Another Page</a>
									</li>
								</ul>
							</li>
							<li class="<cfif rc.action contains 'admin:license'>active</cfif>">
								<a href="#buildURL('admin:license')#"><i class="icon-book"></i> License</a>
							</li>
							<li class="<cfif rc.action contains 'admin:instructions'>active</cfif>">
								<a href="#buildURL('admin:instructions')#"><i class="icon-info-sign"></i> Instructions</a>
							</li>
						</ul><!--- /.nav --->
					</div><!--- /.navbar --->
				</div><!--- /.col-md-12 --->
			</div><!--- .row-fluid --->

			<!--- MAIN CONTENT AREA --->
			<div class="row">
				<cfif rc.action contains 'admin:main'>

					<!--- SUB-NAV --->
					<div class="col-md-3">
						<ul class="nav nav-stacked murafw1-sidenav">
							<li class="<cfif rc.action eq 'admin:main.default'>active</cfif>">
								<a href="#buildURL('admin:main')#"><i class="icon-home"></i> Home</a>
							</li>
							<li class="<cfif rc.action eq 'admin:main.another'>active</cfif>">
								<a href="#buildURL('admin:main.another')#"><i class="icon-leaf"></i> Another Page</a>
							</li>
						</ul>
					</div>

					<!--- BODY --->
					<div class="col-md-9">
						#body#
					</div>

				<cfelse>

					<!--- BODY --->
					<div class="col-md-12">
						#body#
					</div>

				</cfif>
			</div><!--- /.row --->
		</div><!--- /.container-murafw1 --->
	</cfoutput>
</cfsavecontent>
<cfoutput>
	#application.pluginManager.renderAdminTemplate(
		body=local.newBody
		,pageTitle=rc.pc.getName()
		,compactDisplay=rc.compactDisplay
	)#
</cfoutput>
