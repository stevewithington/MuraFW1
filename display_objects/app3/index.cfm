<cfscript>
/**
*
* This file is part of MuraFW1
*
* Copyright 2010-2020 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/

include '../../config.fw1.cfm';
if (IsDefined('objectparams')) {
  StructAppend(form, objectparms);
}
WriteOutput( CreateObject( "#variables.framework.package#.Application" ).init( variables.framework ).doAction( 'app3:main.default' ) );
</cfscript>
