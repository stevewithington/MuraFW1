<!---

This file is part of MuraFW1
Copyright (c) 2010-2012 Stephen J. Withington, Jr.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

--->
<cfinclude template="../includes/fw1config.cfm" />
<cfoutput><plugin>
	<name>#variables.framework.package#</name>
	<package>#variables.framework.package#</package>
	<directoryFormat>packageOnly</directoryFormat>
	<provider>Steve Withington</provider>
	<providerURL>http://stephenwithington.com</providerURL>
	<loadPriority>5</loadPriority>
	<version>#variables.framework.packageVersion#</version>
	<category>Application</category>
	<ormcfclocation />
	<customtagpaths />
	<mappings />
	<settings />
	<eventHandlers>
		<eventHandler event="onApplicationLoad" component="includes.eventHandler" persist="false" />
	</eventHandlers>
	<displayobjects location="global">
		<displayobject name="MuraFW1 Simple Display Object" displayobjectfile="includes/display_objects/simple.cfm" />
		<displayobject name="MuraFW1 App1" displaymethod="dspMuraFW1App1" component="includes.displayObjects" persist="false" />
		<displayobject name="MuraFW1 App2" displaymethod="dspMuraFW1App2" component="includes.displayObjects" persist="false" />
		<displayobject name="MuraFW1 App3" displaymethod="dspMuraFW1App3" component="includes.displayObjects" persist="false" />
	</displayobjects>
</plugin></cfoutput>