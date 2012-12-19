/*

This file is part of MuraFW1

Copyright 2010-2012 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" extends="controller" output="false" {

	// ********************************* PAGES *******************************************

	public any function default(required struct rc) {

		// if we need some service...
		variables.fw.service('myServices.doSomeService', 'thisIsJustSomeRCVariable');

	}

}