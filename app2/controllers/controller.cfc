/*

This file is part of MuraFW1

Copyright 2010-2015 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		All PUBLIC controllers should EXTEND this file.

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {
		
		property name="fw" type="any" default="";
		property name="sampleService"; // used by list.cfc and main.cfc (you may want to place the property for the service directly inside those instead)
		//property name="beanFactory"; // use if you need access to the beanFactory

		public any function init(required any fw) {
			setFW(arguments.fw);
		}

		public any function before(required struct rc) {
			if ( !getFW().isFrontEndRequest() ) {
				getFW().redirect(action='admin:main.default');
			};
		}

}