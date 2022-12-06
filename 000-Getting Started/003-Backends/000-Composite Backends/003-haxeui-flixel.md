haxeui-flixel
================================

haxeui-flixel is the Flixel backend for HaxeUI.

![](./_assets/haxeui-flixel-preview.png)

## Installation
haxeui-flixel has a dependency to haxeui-core, and so that too must be installed. Once haxeui-core is installed, haxeui-flixel can be installed using:

```
haxelib install haxeui-flixel
```

### OpenFL
HaxeFlixel itself is built ontop of OpenFL and is therefore a depenancy that must be installed and setup, this can be done via haxelib using the following commands:

```
haxelib install openfl
haxelib run openfl setup
```

### Flixel
Once OpenFL is installed and setup installing HaxeFlixel can be done with the following commands:

```
haxelib install flixel
haxelib run lime setup flixel
```

## Usage
The simplest method to create a new Flixel application that is HaxeUI ready is to use the HaxeUI command line tools. These tools will allow you to start a new project rapidly with HaxeUI support baked in. To create a new skeleton application using haxeui-flixel create a new folder and use the following command:

```
haxelib run haxeui-core create flixel
```

If however you already have an existing application, then incorporating HaxeUI into that application is straightforward:

### project.xml / application.xml
Simply add the following lines to your `project.xml` or your `application.xml`.

```xml
<haxelib name="haxeui-core" />
<haxelib name="haxeui-openfl" />
```

## Toolkit initialisation and usage
Initialising the toolkit requires you to add this single line somewhere before you start to actually use HaxeUI in your application:

```haxe
Toolkit.init();
```

## Flixel specifics
As well as using the generic `Screen.instance.addComponent`, since HaxeUI components in haxeui-flixel extend from `flixel.group.FlxSpriteGroup` it is also possible to add components directly to any other Flixel sprite / state (eg: `FlxState.add`).