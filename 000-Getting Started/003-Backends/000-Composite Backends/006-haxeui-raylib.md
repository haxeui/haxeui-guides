haxeui-raylib
================================

haxeui-raylib is the RayLib backend for HaxeUI.

![](./_assets/haxeui-raylib_preview.png)

## Installation
haxeui-raylib has a dependency to haxeui-core, and so that too must be installed. Once haxeui-core is installed, haxeui-raylib can be installed using:

```
haxelib install haxeui-raylib
```

### Raylib
haxeui-openfl also has a dependency on raylib-haxe, this can be installed via haxelib using the following command:

```
haxelib install raylib-haxe
```

You will also need to install raylib.

https://github.com/raysan5/raylib/releases

## Usage
The simplest method to create a new native application that is HaxeUI ready is to use the HaxeUI command line tools. These tools will allow you to start a new project rapidly with HaxeUI support baked in. To create a new skeleton application using haxeui-heaps create a new folder and use the following command:

```
haxelib run haxeui-core create raylib
```

If however you already have an existing application, then incorporating HaxeUI into that application is straightforward:

### Haxe build.hxml

If you are using a command line build (via a .hxml file) then add these lines:

```
-lib haxeui-core
-lib haxeui-raylib
-lib raylib-haxe
```


## Toolkit initialisation and usage
Initialising the toolkit requires you to add this single line somewhere before you start to actually use HaxeUI in your application:

```haxe
Toolkit.init();
```