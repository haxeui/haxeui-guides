Preloader
================================
Preloaders provide the visitors important feedback as the application loads. A preloader informs them that a process is in works and most importantly keeps them engaged.

Technically, preloader is just a simple component displayed while the app loads. When the loading phase is finished, the preloader fades out to reveal the application.

By default, HaxeUI preloader is a simple label:

TODO: Image here

Preloaded modules
-------------------------

HaxeUI [modules](http://haxeui.org/api/guides/modules.html) allow their contents to be preloaded before the app starts. To enable such behaviour, set `preload` attribute to `all` for the corresponding module in your `module.xml`:

```xml
<module preload="all">
  ...module contents...
</module>
```

Custom Preloaders
-------------------------
HaxeUI allows one to create custom preloaders easily. To achieve this, a developer should first create a preloader component and then change the value of the corresponding property of an app.

Custom preloader class should extend `haxe.ui.Preloader`. No other restrictions are imposed.

A source code for the simple custom preloader will then look something like this:

```haxe
import haxe.ui.Preloader;

@:xml('
    <preloader width="100%" height="100%">
        <image resource="assets/preloader.gif" horizontalAlign="center" verticalAlign="center" />
    </preloader>
')
class DefaultPreloader extends Preloader 
{
    public function new() 
    {
        super();
    }    
}
```

To achieve more complex behaviour depending on what stage the loading phase is in, a developer may override some of the [parent's methods](http://haxeui.org/api/haxe/ui/preloader/):

```haxe
TODO: More complex example
```

`complete()` is invoked when ...TODO...

`increment()` is invoked when ...TODO...

`progress()` is invoked when ...TODO...

Lastly, to assign the newly created custom preloader to an app, a developer should just change the `preloaderClass` property of an app:

```haxe
class Main {
    public static function main() {
        var app = new HaxeUIApp();
        app.preloaderClass = DefaultPreloader; //Note that its value should be equal to a class of our custom preloader
        app.ready(() -> {
            ...do something...
            app.start();
        });
    }
}
```
