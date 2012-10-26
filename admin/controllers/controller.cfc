/*

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
		All ADMIN controllers should EXTEND this file.

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	property name="fw" type="any" default="";

	public any function init (required fw) {
		setFW(arguments.fw);
	}

	public any function before(required rc) {
		if ( StructKeyExists(rc, '$') ) {
			var $ = rc.$;
		};

		if ( rc.isFrontEndRequest ) {
			getFW().redirect(action='public:main.default');
		};

		if ( !rc.$.currentUser().isLoggedIn() ) {
			location(url='#rc.$.globalConfig('context')#/admin/', addtoken=false);
		};
	}

}