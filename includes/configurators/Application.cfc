/**
* 
* This file is part of MuraFW1
*
* Copyright 2010-2014 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component output=false {
	depth = 4;

	include '#repeatString('../',depth)#config/applicationSettings.cfm';
	include '#repeatString('../',depth)#config/mappings.cfm';
	include '#repeatString('../',depth)#plugins/mappings.cfm';
	include '#repeatString('../',depth)#config/appcfc/onApplicationStart_method.cfm';

	public any function onRequestStart() {
		// NOTE: If you need to allow direct access to a file located 
		// under your site/theme (e.g., a remote web service, etc.),
		// just add the file name to the list of files below.
		var safeFilesList = 'configurator.cfm';

		if ( !ListFindNoCase(safeFilesList, ListLast(cgi.SCRIPT_NAME, '/')) ) {
			WriteOutput('Access Restricted.');
			abort;
		}

		include '#repeatString('../',depth)#config/appcfc/onRequestStart_include.cfm';
		include '#repeatString('../',depth)#config/appcfc/scriptProtect_include.cfm';
		return true;
	}

	include '#repeatString('../',depth)#config/appcfc/onSessionStart_method.cfm';
	include '#repeatString('../',depth)#config/appcfc/onSessionEnd_method.cfm';
	include '#repeatString('../',depth)#config/appcfc/onError_method.cfm';
	include '#repeatString('../',depth)#config/appcfc/onMissingTemplate_method.cfm';
}