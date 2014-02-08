/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="controller" displayname="RegistrationController" {

	property name='framework';
	property name='registrationService';

	// ********************************* PAGES *******************************************

	public void function default(required struct rc) {
		param name='rc.message' default='';
		rc.registrations = variables.registrationService.list();
	}

	public void function form(required struct rc) {
		rc.registration = variables.registrationService.get(argumentCollection=arguments.rc);
	}

	public void function startSave(required struct rc) {
		var registration = variables.registrationService.get(argumentCollection=arguments.rc);
		variables.fw.populate(cfc=registration, keys='fname,lname,issubmitted,id', trim=true);
		rc.message = 'Registration Saved!';
		try {
			variables.registrationService.save(registration);
		} catch (any e) {
			rc.message = e.message;
		};
	}

	public void function endSave(required struct rc) {
		variables.fw.redirect(action='app3:main', preserve='message');
	}

	public void function endDelete(required struct rc) {
		var registration = variables.registrationService.get(argumentCollection=arguments.rc);
		rc.message = 'Registration Deleted!';
		try {
			variables.registrationService.delete(registration.getID());
		} catch (any e) {
			rc.message = e.message;
		};
		variables.fw.redirect(action='app3:main', preserve='message');
	}

	public void function endClear(required struct rc) {
		rc.message = 'All Registrations Have Been Cleared!';
		try {
			variables.registrationService.clearRegistrations();
		} catch (any e) {
			rc.message = e.message;
		};
		variables.fw.redirect(action='app3:main', preserve='message');
	}

}