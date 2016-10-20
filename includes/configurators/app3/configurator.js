/**
*
* This file is part of MuraFW1
*
* Copyright 2010-2016 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
* NOTE: Be sure to change the 'url' attribute!
*/
function initApp3Configurator(data) {

	initConfigurator(data,{
		url: '../plugins/MuraFW1/includes/configurators/app3/configurator.cfm'
		, pars: ''
		, title: 'App 3'
		, init: function(){}
		, destroy: function(){}
		, validate: function(){
			// simple js validation
			if ( !jQuery('#app3message').val() ) {
				var response = alert('Please say something!');
				return false;
			}
			return true;
		}
	});

	return true;

};
