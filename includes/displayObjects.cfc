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

*/
component persistent="false" accessors="true" output="false" extends="mura.plugin.pluginGenericEventHandler" {

	// framework variables
	include 'fw1config.cfm';

	public any function init() {
		return this;
	}

	// ========================== Display Methods ==============================

	public any function dspMuraFW1BasicApp($) {
		return doAction('public:main.default');
	}

	public any function dspMuraFW1SameAppDifferentView($) {
		return doAction('public:list.default');
	}

	// ========================== Helper Methods ==============================

	private string function doAction(string action='') {
		return getApplication().doAction(arguments.action);
	}

	private any function getApplication() {
		if( !StructKeyExists(request, '#getFWValue('package')#Application') ) {
			request['#getFWValue('package')#Application'] = CreateObject('component', '#getFWValue('package')#.Application');
		};
		return request['#getFWValue('package')#Application'];
	}

}