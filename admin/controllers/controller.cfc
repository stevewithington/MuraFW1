/*

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		All ADMIN controllers should EXTEND this file.

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	property name="fw" type="any" default="";

	public any function init (required fw) {
		setFW(arguments.fw);
	}

	public any function before(required rc) {
		if ( StructKeyExists(rc, '$') ) {
			var $ = rc.$;
		};

		if ( rc.isFrontEndRequest ) {
			getFW().redirect(action='public:main.default');
		};

		if ( !rc.$.currentUser().isLoggedIn() ) {
			location(url='#rc.$.globalConfig('context')#/admin/', addtoken=false);
		};
	}

}