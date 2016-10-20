<cfscript>
/*

This file is part of MuraFW1

Copyright 2010-2016 Stephen J. Withington, Jr.
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
	variables.framework.packageVersion = '4.1.2';

	// If true, then each subsystem is treated as its own, individual application, unaware of any other subsystem, and will not respond to requests for any other subsystem. For example, if a link in App2 points to 'buildURL('app3:main.form') as a 'href' tag and is clicked, then App2 will maintain its state and not respond. Only App3 will respond to that request. If false, then it is assumed that you will only have ONE display object on any page at any given time. If you have more than one, then as you interact with it, all of them will respond with the same view. You have been warned!
	variables.framework.siloSubsystems = true;

	variables.framework.debugMode = false; // if TRUE, then additional information is returned by the Application.onError() method

	variables.framework.reloadApplicationOnEveryRequest = false; // change to TRUE if you're developing the plugin so you can see changes in your controllers, etc. ... otherwise, set to FALSE for production

	variables.framework.trace = false; // if true, will print out debugging/tracing info at the bottom of ea. page (within the Plugin's Administration area only)

	// the 'action' defaults to your packageNameAction, (e.g., 'MuraFW1action') you may want to update this to something else.
	// please try to avoid using simply 'action' so as not to conflict with other FW1 plugins
	variables.framework.action = variables.framework.package & 'action';

	// dependency injection framework
	variables.framework.diEngine = 'di1';
	variables.framework.diLocations = 'model,controllers';
	variables.framework.diConfig = {};
	variables.framework.diComponent = variables.framework.package & '.includes.framework.ioc';

	// less commonly modified
	variables.framework.defaultSection = 'main';
	variables.framework.defaultItem = 'default';
	variables.framework.usingSubsystems = true;
	variables.framework.defaultSubsystem = 'admin';

	// by default, fw1 uses 'fw1pk' ... however, to allow for plugin-specific keys, this plugin will use your packageName + 'pk'
	variables.framework.preserveKeyURLKey = variables.framework.package & 'pk';

	// reload application keys
	variables.framework.reload = 'reload';
	variables.framework.password = 'appreload'; // IF you're NOT using the default reload key of 'appreload', then you'll need to update this to match the setting found in /config/settings.ini.cfm!

	// ***** rarely modified *****
	variables.framework.applicationKey = variables.framework.package;
	variables.framework.base = '/' & variables.framework.package;
	variables.framework.generateSES = false;
	variables.framework.SESOmitIndex = true;
	variables.framework.baseURL = 'useRequestURI';
	variables.framework.suppressImplicitService = true; // this used to be false in FW/1 1.x
	variables.framework.suppressServiceQueue = true; // false restores the FW/1 2.2 behavior
	variables.framework.enableGlobalRC = false; // true restores the FW/1 2.2 behavior
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
	}
</cfscript>
