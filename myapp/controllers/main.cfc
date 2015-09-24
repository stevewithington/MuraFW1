/*

This file is part of MuraFW1

Copyright 2010-2015 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="controller" displayname="MyAppController" {

	property name='framework';

	// ********************************* PAGES *******************************************

	public void function default(required struct rc) {
		param name='rc.foo' default='bar';
	}

}