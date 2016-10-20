<cfscript>
/**
*
* This file is part of MuraFW1
*
* Copyright 2010-2016 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/

include '../../config.fw1.cfm';
WriteOutput(new MuraFW1.Application(variables.framework).doAction('app2:main.default'));
</cfscript>
