/*

This file is part of MuraFW1

Copyright 2010-2016 Stephen J. Withington, Jr.
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

	/*
			Important!
			Each FW/1 display object should always call the subapplication's 'main.default' action.
			In other words, don't create a dspSomething('app1:main.someotherview').

			Try to think of each subapplication as its own, independent application, or its own
			little website. Users will be able to interact with it, sometimes calling different
			views within the object itself.

			If you had dspSomething('app1:main.default') in one place, and
			dspSomething('app1:main.someotherview') in another, what do you think would happen when
			you try to pass an action to your application? Well, if your URL had something like
			'?muraFW1Action=app1:main.yetanotherview' ... both displays will update to that view!

			If you wish to override this behaviour, and you plan on only having one display object
			on any given page, then you can set variables.framework.siloSubsystems = false;
			in the file located at /includes/fw1config.cfm
	*/

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
