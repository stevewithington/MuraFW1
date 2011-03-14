<!---

This file is part of muraFW1
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

		Document:	/admin/controllers/main.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.02.04

--->
<cfcomponent extends="mura.cfobject" output="false">

	<cfscript>
		variables.fw = '';

		function init ( fw ) {
			variables.fw = arguments.fw;
		};

		function before ( rc ) {
			var $ = StructNew();
			if ( StructKeyExists(rc, '$') ) {
				$ = rc.$;
			};

			if ( rc.isFrontEndRequest ) {
				fw.redirect(action='public:main.default');
			};
			
		};
	</cfscript>

	<!--- ************ pages *************** --->
	<cffunction name="default" output="false" returntype="any">
		<cfargument name="rc" />
		<!---<cfparam name="rc.save" default="false" />
		<cfparam name="rc.delete" default="false" />--->
		<cfscript>
			// rc.varName = '';
		</cfscript>
	</cffunction>

</cfcomponent>