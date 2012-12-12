# MuraFW1
-------------------------------------------------------------------------------

## Introduction
This is a base Mura CMS plugin using FW/1 as its application 
framework.  It's intended to be used by experienced 
ColdFusion/CFML developers and those developers familiar with 
Framework One, or more commonly known as FW/1.


## PLEASE READ
**This version (3.0) is still in development and has not been fully tested.** 

### Minimum Requirements
	* Mura CMS v.6.0+
	* Adobe ColdFusion 9.0.1+ or Railo 3.3+

## Important Notes
Assuming you've used FW/1 in the past, you'll need to know 
a few minor differences between a typical FW/1 application 
and how it lives within Mura CMS. 

First of all, this plugin does use FW/1 subsystems. There are 
two primary subsystems at play here. One is 'admin' and the 
other is 'public'. This means your URLs will have either 
'?{packageName}Action=admin:your.view' or 
'?{packageName}Action=public:your.view' (e.g., 
?MuraFW1action=admin:default.main). There are also some
additional example applications inlcuded (e.g., app2, app3, etc.).
These are included to give you, the developer, a kind of
'skeleton' application to work with. In addition, this also
illustrates how one would create multiple display objects for
Mura CMS.

Next, here are some of the more important files to be aware of 
and a little bit about what they are.


### /includes/fw1.cfc
This is the file that is typically known in FW/1 as 
**/org/corfield/framework.cfc** You should be able to update this 
with the latest and greatest version available. No modifications 
have been made to the file other than its name.

### /includes/fw1config.cfm
This file contains 'variables.framework' which is used by both 
FW/1 and Mura. The most important variable in this file is: 
`variables.framework.package = 'MuraFW1';` You **MUST** enter 
the plugin's 'packageName' here and it MUST be the same as found 
in **/plugin/config.xml.cfm**  So please be sure to change 
**MuraFW1** to match your plugin's packageName. You should be 
able to simply modify the *package* name in this file and the 
setting should populate `config.xml.cfm` when the plugin is deployed.

Another important variable to note is `framework.baseURL='useRequestURI';`
**Do NOT change this setting!** This setting is required in order 
for Mura CMS and FW/1 to coexist.

Lastly, the `variables.framework.action` defaults to your 
`pacakgeName & action` ... e.g. if your packageName is 'MuraFW1', 
the default action will be **MuraFW1action**.  This is to help 
prevent your plugin from intercepting another plugin's action.  
So, if your packageName is not a valid CFML variable name 
(e.g., begins with a number, etc.) then you will experience 
problems trying to get your application to work.

### /Application.cfc
This file extends /includes/fw1.cfc. Here is where you'll be able 
to edit common FW/1 methods such as setupApplication(), setupSession(), 
setupRequest(), setupSubsystem() if needed. The hope is that you 
shouldn't have to modify it very much for simple applications.

### /includes/eventHandler.cfc
This file extends `mura.plugin.pluginGenericEventHandler`.  Here is 
where you can modify/add commonly used Mura 'events' such as 
onApplicationLoad(), onSiteRequestStart(), onRenderStart(), etc.

### /includes/displayObjects.cfc
This file extends `mura.plugin.pluginGenericEventHandler`.  You 
should be able to add any display methods here.  Just be sure sure 
to map them into your `config.xml.cfm` file so they'll show up for 
content managers.

### /includes/factory/ioc.cfc
This file is DI/1 - Inject One - a very lightweight, convention over
configuration, dependency injection (inversion of control) framework.
By default, this plugin uses DI/1 as its Bean Factory. If you wish
to use something else (e.g., ColdSpring, Mura, etc.), then simply
edit the Appliction.cfc:setupApplication() method.

Please refer to the [DI/1 Project](https://github.com/seancorfield/di1)
for more information.


## Additional Resources
* [MuraFW1 Project Home](http://github.com/stevewithington/MuraFW1)
* [Mura CMS Project Home](http://www.getmura.com)
* [Mura CMS Github Project](http://github.com/blueriver/MuraCMS.git)
* [Mura Support](http://www.getmura.com/index.cfm/support/)
* [Mura Blog](http://www.getmura.com/index.cfm/blog/)
* [Mura Forum](http://www.getmura.com/forum/)
* [FW/1 Project Home](http://fw1.riaforge.org)
* [FW/1 Documentation wiki](http://github.com/seancorfield/fw1/wiki)
* [FW/1 Blog](http://corfield.org/blog/archives.cfm/category/fw1)
* [FW/1 Support](http://groups.google.com/group/framework-one/)
* [DI/1 Project Home](https://github.com/seancorfield/di1)
* [DI/1 Documentation wiki](https://github.com/seancorfield/di1/wiki)

## License
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