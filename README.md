# MuraFW1

This is a base Mura CMS plugin using [FW/1 - Framework One](https://github.com/framework-one/fw1)
as its application framework. It's intended to be used by experienced
ColdFusion/CFML developers and those developers familiar with Framework One,
or more commonly known as FW/1.

## PLEASE READ

### Minimum Requirements
* [Mura CMS](http://www.getmura.com) Core Version 7.0+
* [Adobe ColdFusion](http://www.adobe.com/coldfusion) 2016.0.02.299200
* [Lucee](http://lucee.org) 5.0.0.254


## Important Notes
Assuming you've used FW/1 in the past, you'll need to know
a few minor differences between a typical FW/1 application
and how it lives within Mura CMS.

### Default Subsystems
First of all, this plugin does use FW/1 subsystems. This means your
URLs will have either `?{packageName}Action=admin:your.view`
or `?{packageName}Action=app1:your.view`, etc. For example:
`?MuraFW1action=admin:main.default`.

There are four (4) subsystems in use. The subsystems that are
included by default are:

* **admin**

    This is the primary subsystem. You can and *should* modify it,
    but just don't delete it. This is where authorized content
    managers can go to interact with the plugin's own 'Admin' area.

* **app1**

    This subsystem is just an uber-simple, hello world app. No controllers,
   no layouts, just a `default` view.

* **app2**

    This subsystem is a step up from 'app1' and includes some controllers,
    multiple views, a layout, and also includes a `sample` service.

* **app3**

    This subsystem takes things a few more steps up from 'app2' by
    including an example 'bean' and multiple views. In addition to that,
    this one includes an example of how to create a
    *configurable display object* for Mura CMS.

If you wish to delete any of these, *except for the 'admin' of course*,
just remember to edit the `/plugin/config.xml.cfm` file and either
remove, or comment out, the corresponding `displayObjects` that
have been registered. Once you do this, you will have to go to the
Mura CMS admin area, then to **Settings > Plugins** and click the
pencil icon to edit the plugin, and finally click the **Update** button
in order for Mura to pick up the changes.

### Important Files
Next, here are some of the more important files to be aware of
and a little bit about what they are.

#### /framework/one.cfc
This is the file that is typically known in FW/1 as
**/framework/one.cfc** You should be able to update this
with the latest and greatest version available. No modifications
have been made to the file.

#### /config.fw1.cfm
This file contains `variables.framework` which is used by both
FW/1 and Mura.

##### packageName
The most important variable in this file is:
`variables.framework.package = 'MuraFW1';` You **MUST** enter
the plugin's *packageName* here and it MUST be the same as found
in **/plugin/config.xml.cfm**. So please be sure to change
**MuraFW1** to match your plugin's *packageName*. You should be
able to simply modify the `package` attribute in this file and the
setting should populate `config.xml.cfm` when the plugin is deployed.

Please also note, Mura CMS *also* uses [DI/1](https://github.com/framework-one/di1)
to manage its dependency injection. This means that you **will** run
into issues if you attempt to use any of the names used for its
beans as your `packageName`. In other words, use something unique for
your `packageName`.

##### useRequestURI
Another important variable to note is `framework.baseURL='useRequestURI';`
**Do NOT change this setting!** This setting is required in order
for Mura CMS and FW/1 to coexist.

##### packageNameAction
The `variables.framework.action` defaults to your
`packageName & action` ... e.g. if your packageName is 'MuraFW1',
the default action will be **MuraFW1action**.  This is to help
prevent your plugin from intercepting another plugin's action.
So, if your packageName is not a valid CFML variable name
(e.g., begins with a number, etc.) then you will experience
problems trying to get your application to work.

##### siloSubsystems
Lastly, by default, each subsystem is treated as its own, individual
application, unaware of any other subsystem, and will not respond to
requests for any other subsystem. For example, if a link in App2 points
to `buildURL('app3:main.form')` as a 'href' tag and is clicked, then
App2 will maintain its state and not respond. Only App3 will respond to
that request.

There is a setting to override this default behaviour called:
`variables.framework.siloSubsystems`.

If set to `false`, then it is assumed that you will only have ONE
display object on any page at any given time. If you have more than
one, then as you interact with it, all of them will respond with the
same view. **You have been warned!**

#### /Application.cfc
This file extends /framework/one.cfc. Here is where you'll be able
to edit common FW/1 methods such as setupApplication(), setupSession(),
setupRequest(), setupSubsystem() if needed. The hope is that you
shouldn't have to modify it very much for simple applications.

#### /model/handlers/murafw1.cfc
This file extends `mura.plugin.pluginGenericEventHandler`. Here is
where you can modify/add commonly used Mura 'events' such as
onApplicationLoad(), onSiteRequestStart(), onRenderStart(), etc.



## Additional Resources
* [MuraFW1 Project Source Code](http://github.com/stevewithington/MuraFW1)
* [Mura CMS Project Home](http://www.getmura.com)
* [Mura CMS Project Source Code](http://github.com/blueriver/MuraCMS)
* [Mura CMS Support](http://www.getmura.com/support/)
* [Mura CMS Blog](http://www.getmura.com/blog/)
* [Mura CMS Forum/Google Group](https://groups.google.com/group/mura-cms-developers)
* [FW/1 Project Home](http://fw1.riaforge.org)
* [FW/1 Project Source Code](https://github.com/framework-one/fw1)
* [FW/1 Documentation wiki](https://github.com/framework-one/fw1/wiki)
* [FW/1 Blog](http://corfield.org/blog/archives.cfm/category/fw1)
* [FW/1 Forum/Google Group](http://groups.google.com/group/framework-one/)
* [DI/1 Project Home](https://github.com/framework-one/di1)
* [DI/1 Documentation wiki](https://github.com/framework-one/di1/wiki)


## License
Copyright 2010-2017 Stephen J. Withington, Jr. (and others -- see individual files for additional copyright holders).

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
