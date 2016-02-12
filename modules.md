Modules
================================
Modules are a fundamental part of HaxeUI. Everything from an application to a library is considered a module in HaxeUI terms. The core of HaxeUI (`haxeui-core`) is itself a module. 

Modules allow you do and configure many things inside and application/library:

* Compile resources into an application (as haxe resources)
* Expose component classes and packages (as well as aliasing them)
* Set-up which classes scriptlets have access to (and stop them be eliminated by dead code elimination)
* Create and append to themes
* Set-up (and override) class level properties
* Create (and override) animation sequences

Creation
-------------------------
Modules themselves are simply files that contain markup. By default HaxeUI supports xml, json and yaml markup. It is however possible to inject custom parsers into the the module parsing engine should the need arise. 

To create a module simply create a file called `module.xml` (this example uses xml) somewhere on your classpath. HaxeUI will automatically find this file and load it as part of its module processing phase.

The next step is to simply add the required root node to the xml file:

```xml
<module id="my-module">
</module>
```
_Note: the id attribute is optional but recommended_

Resources
-------------------------
Modules allow you to compile resources directly into your application as haxe resources. This is useful as if you were to share a library you might want to use this feature to make sure that any required resource files would always be available. For example, `haxeui-core` compiles a few small images into the application by default to be used by the default theme. This means that these resources will be available to any and all supported backends without the need for the client application do include them in some framework specific way. 

_Note: from an API perspective you never need to think about if a resource is a haxe resource or a backend specific resource when you use resource in HaxeUI the framework will work out if its a haxe resource or not and automatically convert it into the correct type for the framework that is currently being used._

To set-up a module to discover and compile in resources, use the `<resources/>` node. Here is an example from the `haxeui-core` module:

```xml
<resources>
	<resource path="/haxe/ui/_module/styles" prefix="haxeui-core/styles" />
</resources>
```

* `path` specifies where on the classpath to look for resources.
* `prefix` specifies what name should be added before the resolved resource path
 
The resource compilation stage is fully recursive mean all files in all folders will be discovered and added as haxe resources. The prefix is important if you want to make your names a little more user friendly. Assuming you had the following folder structure:

```
haxe
 |-- ui
     |-- _module
         |-- styles
             |-- myimage.png
             |-- myfolder
                 |-- myotherimage.png
```

Then you would end up with this resource names:

* haxeui-core/styles/myimage.png
* haxeui-core/styles/myfolder/myotherimage.png
 
Components
-------------------------
Within HaxeUI its necessary to let the framework know what components should be available to a give application. This is also achieved via modules. It lets the framework know what classes or packages to scan looking for classes that extend `Component` and register them in the component registry. This stage is required mainly to allow for xml (and other mark up) to be used to be build user interfaces. If a component wasnt registered in a module then it is still fully accessible to normal haxe code, it however, wouldnt be available to xml (or markup based) UI definitions. 

To register components, or sets of components with the framework simply use the `<components />` node. Here is an example from the `haxeui-core` module:

```xml
<components>
	<class name="haxe.ui.core.Component" />
	<class package="haxe.ui.components" />
	<class package="haxe.ui.containers" />
	<class name="haxe.ui.components.Label" alias="text" />
</components>
```

* `name` specifies which class is extended from `Component`
* `package` specifies an entire package to scan
* `alias` specifies what name to use in the component registry, if this is omitted then the class name is used (made lower case)

_Note: if you specify `package` then `alias` will be ignored and all classes in the package that are descendants of `Component` will be registered using their lower-case class name_

_Trivia: the static text class `Label` has been aliased in `haxeui-core` in order to ease migration from v1 to v2_ 

Its important to realise that having these classes registered via the module makes no guarantee that they wont be eliminated by dead code elimination if they havent been used in an application.

Scripting
-------------------------
HaxeUI supports a fully feature scripting environment provided via `hscript`. This can allow very quick debugging and dynamic functionality to an application with ease. Setting up certain configurations in the module can greatly help with basic scripting issues, namely class naming and dead code elimination. 

The first slight annoyance is that in `hscript` you have to use fully qualified names since there is no such things as `import` statements. This means to create button dynamically in a HaxeUI `scriptlet` you would have to so something similar along then lines of:

```haxe
var button = new haxe.ui.components.Button();
```

This is fine of course, but it would be nicer to not have to think about quite so much and just use `Button`. This is achieved by _registering_ which classes will be available to scripts so that the script interpreter can intercept calls to `new`and decide to substitute a fully qualified path. An example would be:

```xml
<import class="haxe.ui.core.Component" />
<import package="haxe.ui.components" />
<import package="haxe.ui.containers" />
```

This lets HaxeUI know that the class `Component` and all the classes in `haxe.ui.components` and `haxe.ui.containers` should be able to be referred to by just thier class name. With this in _any_ module, we can use sciptlets like the following:

```haxe
var button = new Button();
var view = new ScrollView();
```

This however, does not mean that this scriptlet would run correctly. If dead code elimination is enabled (and it should be) then the haxe compiler would have no idea that these classes are actually going to be used in the application (unless they are used else where in _real_ haxe code). To remedy this we could use the `keep` attribute in the module:

```xml
<import package="haxe.ui.components.Button" keep="true" />
<import package="haxe.ui.containers.ScrollView" keep="true" />
```
These classes will now be marked using meta data so the haxe compiler will stop them from being dead code eliminated. 

_Note: the `keep` attribute can also be used for entire package_

The final thing the module can do in regards to scriptlets is to allow the addition of helper classes to be automatically included in the scripting environment. This is simply achieved with the `static` attribute as shown below:

```xml
<import class="Std" keep="true" static="true" />
<import class="Math" keep="true" static="true" />
```

The haxe utility classes `Std` and `Math` will now be available for use inside every scripting environment created. 

_Note: dead code elimination also applies to helper classes and so these are also marked as `keep`_

For compleness the following listing shows how things are configured by default via the `haxeui-core` module:

```xml
<scriptlets>
	<import class="haxe.ui.core.Component" keep="true" />
	<import package="haxe.ui.components" />
	<import package="haxe.ui.containers" />
	<import package="haxe.ui.animation" keep="true" />
	<import class="Std" keep="true" static="true" />
	<import class="Math" keep="true" static="true" />
	<import class="haxe.ui.core.Screen" static="true" />
	<import class="haxe.ui.animation.AnimationManager" static="true" />
</scriptlets>
```

Themes
-------------------------
Modules are a good place to create and extend themes that are available to HaxeUI. They can be defined simply by using the `<themes />` node. Here is an example from the `haxeui-core` module:

```xml
<themes>
	<global>
		<style resource="haxeui-core/styles/global.css" />
	</global>
	<default>
		<style resource="haxeui-core/styles/default/main.css" />
	</default>
	<native parent="default">
		<style resource="haxeui-core/styles/native/main.css" />
	</native>
</themes>
```

Properties
-------------------------
Here is an example from the `haxeui-core` module:

```xml
<properties>
	<property name="haxe.ui.components.hslider.animation.pos" value="haxe.ui.components.animation.pos" />
	<property name="haxe.ui.components.hslider.animation.rangeStart" value="haxe.ui.components.animation.rangeStart" />
	<property name="haxe.ui.components.hslider.animation.rangeEnd" value="haxe.ui.components.animation.rangeEnd" />

	<property name="haxe.ui.components.vslider.animation.pos" value="haxe.ui.components.animation.pos" />
	<property name="haxe.ui.components.vslider.animation.rangeStart" value="haxe.ui.components.animation.rangeStart" />
	<property name="haxe.ui.components.vslider.animation.rangeEnd" value="haxe.ui.components.animation.rangeEnd" />
		
	<property name="haxe.ui.components.hscroll.animation.pos" value="haxe.ui.components.animation.pos" />
	
	<property name="haxe.ui.components.vscroll.animation.pos" value="haxe.ui.components.animation.pos" />
</properties>
```

Animation
-------------------------
Here is an example from the `haxeui-core` module:

```xml
<animations>
	<animation id="haxe.ui.components.animation.pos" ease="Bounce.easeOut">
		<keyframe time="300">
			<target pos="{pos}" />
		</keyframe>
	</animation>
	<animation id="haxe.ui.components.animation.rangeStart" ease="Bounce.easeOut">
		<keyframe time="300">
			<target rangeStart="{rangeStart}" />
		</keyframe>
	</animation>
	<animation id="haxe.ui.components.animation.rangeEnd" ease="Bounce.easeOut">
		<keyframe time="300">
			<target rangeEnd="{rangeEnd}" />
		</keyframe>
	</animation>
</animations>
```