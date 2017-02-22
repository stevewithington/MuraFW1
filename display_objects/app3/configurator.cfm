<cfscript>
/**
*
* This file is part of MuraFW1
*
* Copyright 2010-2017 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/

  // Mura Scope
  if ( !IsDefined('m') ) {
    m = StructKeyExists(session, 'siteid')
      ? application.serviceFactory.getBean('MuraScope').init(session.siteid)
      : application.serviceFactory.getBean('MuraScope').init('default');
  }

  param name='objectparams.app3message' default='';
</cfscript>

<cfoutput>
	<!--- Message --->
  <div class="mura-control-group">
    <label class="mura-control-label" for="app3message">App3 Message</label>
    <input type="text"
      name="app3message"
      id="app3message"
      class="objectParam"
      value="#objectparams.app3message#" />
  </div>

  <input type="hidden" name="configuredDTS" class="objectParam" value="#Now()#" />
  <input type="hidden" name="configuredBy" class="objectParam" value="#esapiEncode('html_attr', m.currentUser('LName'))#, #esapiEncode('html_attr', m.currentUser('FName'))#" />
</cfoutput>
