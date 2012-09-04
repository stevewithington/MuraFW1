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

		Document:	/admin/controllers/controller.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Notes:		All ADMIN controllers should EXTEND this file.

--->
<cfcomponent extends="mura.cfobject" output="false">

	<cfscript>
		variables.fw = '';

		function init ( fw ) {
			variables.fw = arguments.fw;
		};
	</cfscript>

	<cffunction name="before" output="false" returntype="any">
		<cfargument name="rc" required="true" />
		<cfscript>
			if ( StructKeyExists(rc, '$') ) {
				var $ = rc.$;
			};

			if ( rc.isFrontEndRequest ) {
				fw.redirect(action='public:main.default');
			}
		</cfscript>
		<cfif not rc.$.currentUser().isLoggedIn()>
			<cflocation url="#rc.$.globalConfig('context')#/admin/" addtoken="false" />
		</cfif>
	</cffunction>

</cfcomponent>