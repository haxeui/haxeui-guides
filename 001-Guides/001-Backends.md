Backends
================================
A `backend` is the term used to refer to what HaxeUI uses to delegate component creation, event registration and rendering to. The core of the library (`haxeui-core`) handles layout, scripting, binding, invalidation sequence and such common tasks, whilst the backend in question is responsible for actually displaying something on screen, mapping of events from HaxeUI's generic `UIEvent` to something the host backend uses and such framework specific tasks.

In general getting HaxeUI to work with one of the supported backends is fairly trivial and follows these general steps:

* Install `haxeui-core`
* Install haxeui backend library
* Install dependencies of backend library

Haxelib itself should handle these steps for you. They are only listed here for completeness. 

Supported Backends
-------------------------
The following list is all of the currently supported HaxeUI backends:

Framework | Backend Library  | Dependencies         | Platforms |
--------- | ---------------- | -------------------- | ---------
Flambe    | haxeui-flambe    | flambe               | Mobile, Browser
HTML5     | haxeui-html5     | none                 | Browser **
Kha       | haxeui-kha       | kha                  | Desktop, Mobile, Browser
Luxe      | haxeui-luxe      | luxe                 | Desktop, Mobile, Browser
NME       | haxeui-nme       | nme                  | Desktop, Mobile, Browser
OpenFL    | haxeui-openfl    | openfl, lime         | Desktop, Mobile, Browser
PixiJS    | haxeui-pixi      | pixijs               | Browser
hxWidgets | haxeui-hxwidgets | hxWidgets, wxWidgets | Desktop **
Raylib    | haxeui-raylib    | raylib-haxe          | Desktop
Heaps     | haxeui-heaps     | heaps                | Desktop, Mobile, Browser
PDCurses  | haxeui-pdcurses  |                      | Desktop
Flixel    | haxeui-flixel    | flixel               | Desktop, Mobile, Browser

** Produces OS native components