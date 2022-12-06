Installing HaxeUI
================================

Haxe comes with package manager named HaxeLib, this is the simplest method to install HaxeUI and can be achieved by opening a terminal and using the command:

```
haxelib install haxeui-core
```

And thats it! You now have the core library of HaxeUI installed, however, haxeui-core by itself will do little - it needs to be coupled with a [backend](backends/index.html) in order to be used.

HaxeUI Command Line Tools
-------------------------

HaxeUI comes with an optional command line too that can make project creation that little bit simpler. It takes the form of a haxelib run command, and can be used in the following manner:

```
haxelib run haxeui-core {command} {options}
```

For example, to create a blank html5 project using haxeui-html5, simply create an empty directory, open a command prompt in that directory and use:

```
haxelib run haxeui-core create html5
```

To get help with the command line tool use

```
haxelib run haxeui-core help
```

_Note: You can also set up an alias for "haxelib run haxeui-core" to make commands even shorter, once that is done you can simply use things like "haxeui help" or "haxeui create html5"_