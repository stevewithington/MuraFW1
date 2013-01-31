/*

This file is part of MuraFW1

Copyright 2010-2013 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		All ADMIN controllers should EXTEND this file.

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	property name='$';
	property name='fw';

	public any function init (required any fw) {
		setFW(arguments.fw);
	}

	public any function before(required struct rc) {
		if ( StructKeyExists(rc, '$') ) {
			var $ = rc.$;
			set$(rc.$);
		};

		// easy access to site attributes
		// rc.settingsManager = rc.$.getBean('settingsManager');
		// rc.siteBean = rc.settingsManager.getSite(rc.$.siteConfig('siteid'));
		// rc.siteName = rc.siteBean.getSite();
		// rc.rsAllSites = rc.settingsManager.getList();
		// rc.rsSites = rc.pc.getAssignedSites();
		// rc.listSites = ValueList(rc.rsSites.siteid);

		if ( rc.isFrontEndRequest ) {
			//getFW().redirect(action='public:main.default');
			location(url='#rc.$.globalConfig('context')#/', addtoken=false);
		} else if ( !rc.$.currentUser().isSuperUser() ) { // lock app down to Super Users only
			location(url='#rc.$.globalConfig('context')#/admin/', addtoken=false);
		};

	}

}