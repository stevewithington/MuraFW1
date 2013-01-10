<cfscript>
/*

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		The most important variable to note is variables.framework.package.
		Also, set variables.framework.debugMode to false when you're finished
		developing the plugin.

*/
	// FW1 Configuration
	variables.framework = {};

	// !important: enter the plugin packageName here. must be the same as found in '{context}/plugin/config.xml.cfm'
	variables.framework.package = 'MuraFW1';
	variables.framework.packageVersion = '3.015';

	// If true, then additional information is returned by the Application.onError() method
	// and FW1 will 'reloadApplicationOnEveryRequest' (unless explicitly set otherwise below).
	variables.framework.debugMode = true;
	
	// change to TRUE if you're developing the plugin so you can see changes in your controllers, etc.
	variables.framework.reloadApplicationOnEveryRequest = variables.framework.debugMode ? true : false;

	// the 'action' defaults to your packageNameAction, (e.g., 'MuraFW1action') you may want to update this to something else.
	// please try to avoid using simply 'action' so as not to conflict with other FW1 plugins
	variables.framework.action = variables.framework.package & 'action';

	// less commonly modified
	variables.framework.defaultSection = 'main';
	variables.framework.defaultItem = 'default';
	variables.framework.usingSubsystems = true;
	variables.framework.defaultSubsystem = 'admin';

	// by default, fw1 uses 'fw1pk' ... however, to allow for plugin-specific keys, this plugin will use your packageName + 'pk'
	variables.framework.preserveKeyURLKey = variables.framework.package & 'pk';

	// ***** rarely modified *****
	variables.framework.applicationKey = variables.framework.package;
	variables.framework.base = '/' & variables.framework.package;
	variables.framework.reload = 'reload';
	variables.framework.password = 'appreload'; // IF you're NOT using the default reload key of 'appreload', then you'll need to update this!
	variables.framework.generateSES = false;
	variables.framework.SESOmitIndex = true;
	variables.framework.baseURL = 'useRequestURI';
	variables.framework.suppressImplicitService = false; //true to suppress fw/1 from storing service calls results in rc.data
	variables.framework.unhandledExtensions = 'cfc';
	variables.framework.unhandledPaths = '/flex2gateway';
	variables.framework.maxNumContextsPreserved = 10;
	variables.framework.cacheFileExists = false;

	if ( variables.framework.usingSubSystems ) {
		variables.framework.subsystemDelimiter = ':';
		variables.framework.siteWideLayoutSubsystem = 'common';
		variables.framework.home = variables.framework.defaultSubsystem & variables.framework.subsystemDelimiter & variables.framework.defaultSection & '.' & variables.framework.defaultItem;
		variables.framework.error = variables.framework.defaultSubsystem & variables.framework.subsystemDelimiter & variables.framework.defaultSection & '.error';
	} else {
		variables.framework.home = variables.framework.defaultSection & '.' & variables.framework.defaultItem;
		variables.framework.error = variables.framework.defaultSection & '.error';
	};
</cfscript>