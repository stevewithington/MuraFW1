/*

This file is part of MuraFW1

Copyright 2010-2013 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	public any function init() {
		return this;
	}

	public any function doSomeService(string someArgument='Hello from services.public.doSomeService()') {
		// do whatever you need in here :)
		return arguments.someArgument;
	}

	public any function getDeveloperList() {
		return 'Matt Levine,Sean Schroeder,Steve Withington,Grant Shepert,Eddie Ballisty';
	}

}