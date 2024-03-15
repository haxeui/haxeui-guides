Preloader
================================
Preloaders provide the visitors important feedback as the application loads. A preloader informs them that a process is in works and most importantly keeps them engaged.

Technically, preloader is just a simple component displayed while the app loads. When the loading phase is finished, the preloader fades out to reveal the application.

By default, HaxeUI preloader is a simple label:

![image](https://user-images.githubusercontent.com/16256911/210350723-d77b7dfb-c65a-4fe8-87dd-bf02804a0ca6.png)

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
import haxe.ui.Preloader;

@:xml('
    <preloader width="100%" height="100%">
        <vbox width="100%" verticalAlign="center">
            <image resource="assets/preloader.gif" horizontalAlign="center" />
            <label id="progressLabel" horizontalAlign="center" />
        </vbox>
    </preloader>
')
class DefaultPreloader extends Preloader 
{
    override public function complete() 
    {
        trace("Loading complete, removing preloader");
        super.complete();
        trace("Preloader removed");
    }   
    
    override public function increment() 
    {
        trace("Progress incremented");
        super.increment();
    }     
    
    override public function progress(current:Int, max:Int) 
    {
        super.progress(current, max);
        progressLabel.text = 'Loading: $current/$max';
    }    
    
    public function new() 
    {
        super();
    }    
}
```

`progress()` is invoked on any loading progress change. **In most of the cases, this is the only method you'll need to override.**

`complete()` is invoked when the loading is finished. In the original implementation, it consists of a single line responsible for removing the preloader from the screen. You may override this method if you'll need some additional cleanup before or after the preloader is removed.

`increment()` is invoked when the current loading progress is increased by 1. Under the hood, it consists of the `progress()` call, so there's no much sense in overriding it.

Lastly, to assign the newly created custom preloader to an app, a developer should just change the `preloaderClass` property of an app:

```haxe
class Main 
{
    public static function main() 
    {
        var app = new HaxeUIApp();
        app.preloaderClass = DefaultPreloader; //Note that its value should be equal to a class of our custom preloader
        app.ready(() -> {
            ...do something...
            app.start();
        });
    }
}
```
