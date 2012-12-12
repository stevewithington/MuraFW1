/*

This file is part of MuraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

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