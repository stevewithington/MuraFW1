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

		Document:	fw1config.cfm
		Author:		Steve Withington | www.stephenwithington.com

--->
<cfscript>
	framework = StructNew();

	// !important: enter the plugin packageName here. must be the same as found in '{context}/plugin/config.xml.cfm'
	framework.package = 'muraFW1';
	
	// change to TRUE if you're developing the plugin so you can see changes in your controllers, etc.
	framework.reloadApplicationOnEveryRequest = false;

	// the 'action' defaults to your packageNameAction, i.e., 'muraFW1action' ... you may want to update this to something else.
	// please try to avoid using simply 'action' so as not to conflict with other FW1 plugins
	framework.action = framework.package & 'action';

	// less commonly modified
	framework.defaultSection = 'main';
	framework.defaultItem = 'default';
	framework.usingSubSystems = true;
	framework.defaultSubsystem = 'public';

	// by default, fw1 uses 'fw1pk' ... however, to allow for plugin-specific keys, this plugin will use your packageName + 'pk'
	framework.preserveKeyURLKey = framework.package & 'pk';

	// ***** rarely modified *****
	framework.applicationKey = framework.package;
	framework.base = '/' & framework.package;
	framework.reload = 'reload';
	framework.password = 'appreload'; // IF you're NOT using the default reload key of 'appreload', then you'll need to update this!
	framework.generateSES = false;
	framework.SESOmitIndex = true;
	framework.baseURL = 'useRequestURI';
	framework.suppressImplicitService = false;
	framework.unhandledExtensions = 'cfc';
	framework.unhandledPaths = '/flex2gateway';
	framework.maxNumContextsPreserved = 10;
	framework.cacheFileExists = false;

	if ( framework.usingSubSystems ) {
		framework.subsystemDelimiter = ':';
		framework.siteWideLayoutSubsystem = 'common';
		framework.home = framework.defaultSubsystem & framework.subsystemDelimiter & framework.defaultSection & '.' & framework.defaultItem;
		framework.error = framework.defaultSubsystem & framework.subsystemDelimiter & framework.defaultSection & '.error';
	} else {
		framework.home = framework.defaultSection & '.' & framework.defaultItem;
		framework.error = framework.defaultSection & '.error';
	};
</cfscript>