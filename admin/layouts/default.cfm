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
	<cfsavecontent variable="local.errors">
		<cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
			<div class="alert alert-error">
				<button type="button" class="close" data-dismiss="alert"><i class="icon-remove-sign"></i></button>
				<h2>Alert!</h2>
				<h3>Please note the following message<cfif ArrayLen(rc.errors) gt 1>s</cfif>:</h3>
				<ul>
					<cfloop from="1" to="#ArrayLen(rc.errors)#" index="local.e">
						<li>
							<cfif isSimpleValue(rc.errors[local.e])>
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
		<div class="container-murafw1">

			<!--- PRIMARY NAV --->
			<div class="row-fluid">
				<div class="navbar">
					<div class="navbar-inner">
						<a class="plugin-brand" href="#buildURL('admin:main')#">#HTMLEditFormat(rc.pc.getPackage())#</a>
						<ul class="nav">
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
					</div><!--- /.navbar-inner --->
				</div><!--- /.navbar --->
			</div><!--- /.row --->

			<!--- MAIN CONTENT AREA --->
			<div class="row-fluid">
				<cfif rc.action contains 'admin:main'>

					<!--- SUB-NAV --->
					<div class="span3">
						<ul class="nav nav-list murafw1-sidenav">
							<li class="<cfif rc.action eq 'admin:main.default'>active</cfif>">
								<a href="#buildURL('admin:main')#"><i class="icon-home"></i> Home</a>
							</li>
							<li class="<cfif rc.action eq 'admin:main.another'>active</cfif>">
								<a href="#buildURL('admin:main.another')#"><i class="icon-leaf"></i> Another Page</a>
							</li>
						</ul>
					</div>
					<!--- BODY --->
					<div class="span9">
						#body#
					</div>

				<cfelse>

					<!--- BODY --->
					<div class="span12">
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