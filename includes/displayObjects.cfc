/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="mura.plugin.pluginGenericEventHandler" {

	// framework variables
	include 'fw1config.cfm';

	public any function init() {
		return this;
	}

	// ========================== Display Methods ==============================

	public any function dspMuraFW1App1($) {
		return getApplication().doAction('app1:main.default');
	}

	public any function dspMuraFW1App2($) {
		return getApplication().doAction('app2:main.default');
	}

	public any function dspMuraFW1App3($) {
		return getApplication().doAction('app3:main.default');
	}

	// ========================== Configured Display Object(s) ================

	public any function dspConfiguredMuraFW1App3($) {
		var local = {};
		local.params = arguments.$.event('objectParams');

		local.defaultParams = {
			app3message = 'Hello from App3'
		};

		StructAppend(local.params, local.defaultParams, false);

		// Stuff the params into the rc scope
		request.context.params = local.params;

		return dspMuraFW1App3(arguments.$);
	}

	// ========================== Helper Methods ==============================

	private any function getApplication() {
		if( !StructKeyExists(request, '#variables.framework.applicationKey#Application') ) {
			request['#variables.framework.applicationKey#Application'] = new '#variables.framework.package#.Application'();
		};
		return request['#variables.framework.applicationKey#Application'];
	}

}