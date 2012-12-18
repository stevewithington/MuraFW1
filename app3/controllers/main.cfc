/*

This file is part of MuraFW1
Copyright (c) 2010-2012 Stephen J. Withington, Jr.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

	NOTES:

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