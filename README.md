# MuraFW1
------------------------------------------------------------------------------------------

## Introduction
This is a base Mura CMS plugin using FW/1 as its application framework.  It's intended
to be used by experienced ColdFusion/CFML developers and those developers familiar with 
Framework One, or more commonly known as FW/1.


## Important Notes
Assuming you've used FW/1 in the past, you'll need to know a few minor differences
between a typical FW/1 application and how it lives within Mura CMS. 

First of all, this plugin does use FW/1 subsystems. There are two primary subsystems 
at play here. One is 'admin' and the other is 'public'. This means your URLs will have 
either '?{packageName}Action=admin:your.view' or '?{packageName}Action=public:your.view'
(e.g., ?muraFW1action=admin:default.main)

Next, here are some of the more important files to be aware of and a little bit about
what they are.


### fw1.cfc
This is the file that is typically known in FW/1 as **/org/corfield/framework.cfc** You
should be able to update this with the latest and greatest version available. No
modifications have been made to the file other than its name.

### fw1config.cfm
This file contains 'variables.framework' which is used by both FW/1 and Mura. The most
important variable in this file is:	variables.instance.package = 'muraFW1';
You MUST enter the plugin's 'packageName' here and it MUST be the same as found in 
'/plugin/config.xml.cfm'  So please be sure to change 'muraFW1' to match your plugin's
packageName.  Another important variable to note is 
variables.framework.baseURL='useRequestURI';  Do NOT change this setting! This setting is
required in order for Mura CMS and FW/1 to coexist.

Lastly, the framework.action defaults to your pacakgeName & 'action' ... i.e. if your
packageName is 'muraFW1', the default action will be 'muraFW1action'.  This is to
help prevent your plugin from intercepting another plugin's action.  So, if your
packageName is not a valid ColdFusion variable name (i.e., begins with a number, etc.)
then you will experience problems trying to get your application to work.

### Application.cfc
This file extends fw1.cfc. Here is where you'll be able to edit common FW/1 methods
such as setupApplication(), setupSession(), setupRequest(), setupSubsystem() if needed.

### pluginEventHandler.cfc
This file extends mura.plugin.pluginGenericEventHandler.  Here is where you can access
commonly used Mura 'events' such as onApplicationLoad(), onSiteRequestStart(),
onRenderStart(), etc.


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