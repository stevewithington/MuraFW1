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
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	property name='sessionKey';

	public any function init() {

		setSessionKey(Hash('MuraFW1_Registrations'));
		setRegistrations();

		return this;
	}

	public void function setRegistrations() {
		if ( !StructKeyExists(session, getSessionKey())) {
			lock scope='session' type='exclusive' timeout=10 {
				session[getSessionKey()] = {
					nextID = 1
					, registrations = {}
				};
			};
		};
	}

	public void function clearRegistrations() {
		StructDelete(session, getSessionKey());
		setRegistrations();
	}

	public any function getRegistrations() {
		lock scope='session' type='readonly' timeout=10 {
			return session[getSessionKey()].registrations;
		};
	}

	public any function getNextID() {
		lock scope='session' type='readonly' timeout=10 {
			return session[getSessionKey()].nextID;
		};
	}

	public void function setNextID(nextID='#getNextID()+1#') {
		lock scope='session' type='exclusive' timeout=10 {
			session[getSessionKey()].nextID = arguments.nextID;
		};
	}

	public boolean function delete(required string id) {
		lock scope='session' type='exclusive' timeout=10 {
			return StructDelete(getRegistrations(), arguments.id);
		};
	}

	public any function get(string id='') {
		var result = '';
		var r = getRegistrations();
		if ( Len(arguments.id) && StructKeyExists(r, arguments.id) ) {
			result = r[arguments.id];
		} else {
			result = new();
		};
		return result;
	}

	public struct function list() {
		return getRegistrations();
	}

	public any function new() {
		return new MuraFW1.app3.model.beans.registration();
	}

	public void function save(required any registration) {
		var newID = '';
		var r = getRegistrations();
		if ( Len(arguments.registration.getID()) ) {
			lock scope='session' type='exclusive' timeout=10 {
				r[arguments.registration.getID()] = arguments.registration;
			};
		} else {
			lock scope='session' type='exclusive' timeout=10 {
				newID = getNextID();
				setNextID(getNextID()+1);
			};
			arguments.registration.setID(newID);
			lock scope='session' type='exclusive' timeout=10 {
				r[newID] = arguments.registration;
			};
		};
	}

}