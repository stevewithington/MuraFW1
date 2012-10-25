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

	// ========================== Mura CMS Specific Methods ==============================
	// Add any other Mura CMS Specific methods you need here.

	public void function onApplicationLoad(required struct $) {
		variables.pluginConfig.addEventHandler(this);
	}
	
	public void function onSiteRequestStart(required struct $) {
		arguments.$.setCustomMuraScopeKey(getFWValue('package'), getApplication());
	}

	public any function onRenderStart(required struct $) {
		arguments.$.loadShadowboxJS();
	}

	
	// ========================== Helper Methods ==============================

	// If you need to call any of the Application.cfc methods, you can use getApplication().theMethod()
	private any function getApplication() {
		if( !StructKeyExists(request, '#getFWValue('package')#Application') ) {
			request['#getFWValue('package')#Application'] = CreateObject('component', '#getFWValue('package')#.Application');
		};
		return request['#getFWValue('package')#Application'];
	}

}

