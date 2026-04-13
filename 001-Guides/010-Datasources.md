# Datasources

Multiple components use `datasource` to store their data. It is usually used to store an array of data.
Those components implements `IDataComponent`


For example a listview use a datasource. The xml
```xml
<listview id="lv1" width="200" height="150" selectedIndex="0">
    <data>
        <item text="Haxe" icon="icons/logo-haxe.png" />
        <item text="Java" icon="icons/logo-java.png" />
        <item text="Javascript" icon="icons/logo-javascript.png" />
        <item text="C++" icon="icons/logo-cpp.png" />
        <item text="PHP" icon="icons/logo-php.png" />
        <item text="C#" icon="icons/logo-cs.png" />
        <item text="F#" icon="icons/logo-fs.png" />
        <item text="OCaml" icon="icons/logo-ocaml.png" />
        <item text="Assembler" icon="icons/logo-asm.png" />
    </data>
</listview>
```
is translated as this code
```haxe
    var ds1 = new haxe.ui.data.ArrayDataSource();
	ds1.add({text : "Haxe", icon : "icons/logo-haxe.png", id : "item"});
	ds1.add({text : "Java", icon : "icons/logo-java.png", id : "item"});
	ds1.add({text : "Javascript", icon : "icons/logo-javascript.png", id : "item"});
	ds1.add({text : "C++", icon : "icons/logo-cpp.png", id : "item"});
	ds1.add({text : "PHP", icon : "icons/logo-php.png", id : "item"});
	ds1.add({text : "C#", icon : "icons/logo-cs.png", id : "item"});
	ds1.add({text : "F#", icon : "icons/logo-fs.png", id : "item"});
	ds1.add({text : "OCaml", icon : "icons/logo-ocaml.png", id : "item"});
	ds1.add({text : "Assembler", icon : "icons/logo-asm.png", id : "item"})
    lv1.dataSource  = ds1;
```

## Uses of datasources

Datasources are used little bit differently depending on components.
Most datasources are used to be used in conjunction with item renderers.
But there are a few exceptions.


### Datasources for items to be used by an item renderer

#### Item renderers, a way to render  an item stored in the datasource

```xml
<listview id="lv2" width="200" height="150" selectedIndex="1">
    <item-renderer layout="horizontal" width="100%">
        <checkbox id="complete" />
        <label width="100%" id="item" verticalAlign="center" />
        <image id="image" />
    </item-renderer>
    <data>
        <item complete="false" item="Item 1" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="true" item="Item 2" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="true" item="Item 3" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="false" item="Item 4" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="true" item="Item 5" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="true" item="Item 6" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="false" item="Item 7" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="true" item="Item 8" image="haxeui-core/styles/default/haxeui_tiny.png" />
        <item complete="false" item="Item 9" image="haxeui-core/styles/default/haxeui_tiny.png" />
    </data>
</listview>
```

An item renderer is basically a container, a box with components.
That's why you can do `<item-renderer layout="horizontal" width="100%">`


Components that combine both an item-renderer and datasource do it this way.

For each item in the datasource
- The item-renderer will be cloned
- The cloned component will be added as a component child
- Something will be done with the info in the item


### Dropdown, List, Tables
- The item is cloned
- The cloned component is added as a component child
- Then some values is initialised from the item info 
    ` <item complete="false" item="Item 1" image="haxeui-core/styles/default/haxeui_tiny.png" />`
    It will look for the component with the id 'complete' which is a checkbox and set the value to false, look at the component with the id 'item' and set the value to 'Item1' etc. 

### Datasources for option-steppers

```xml
<option-stepper width="100">
    <data>
        <item text="Haxe" />
        <item text="Java" />
        <item text="Javascript" />
        <item text="C++" />
        <item text="PHP" />
        <item text="C#" />
        <item text="F#" />
        <item text="OCaml" />
        <item text="Assembler" />
    </data>
</option-stepper>
```

Option steppers only use the datasource as an array of text. The option stepper will change it's value to the  previous/next item text when clicked on.


### Datasources for canvases

```xml
<canvas width="110" height="50" horizontalAlign="center">
    <data>
        <!-- draw olympic rings (badly) -->
        <fill-style color="none" alpha="0" />
        <!-- blue ring -->
        <stroke-style color="#407ec9" thickness="3" />
        <circle x="20" y="20" radius="14" />
        <!-- black ring -->
        <stroke-style color="#000000" thickness="3" />
        <circle x="55" y="20" radius="14" />
        <!-- red ring -->
        <stroke-style color="#d8414f" thickness="3" />
        <circle x="90" y="20" radius="14" />
        <!-- yellow ring -->
        <stroke-style color="#efb730" thickness="3" />
        <circle x="38" y="30" radius="14" />
        <!-- green ring -->
        <stroke-style color="#4ea74f" thickness="3" />
        <circle x="73" y="30" radius="14" />
    </data>
</canvas>
```

Canvas uses datasource as a way to store drawing actions.

### Datasource events

Datasources as components, also dispatches events. It can dispatch an event when item is added to the datasource, removed, etc.

You must set them by code. You CANNOT set to them in the xml <data onAdd="trace('data changed')"> doesn't work for now.


### DataSource filtering and sorting








## Creating a datasource from code

An advantage of setting a datasource through code instead of xml, is you can have typed datasources. Xml datasources are usually an array of objects.



Instead of having
```haxe
var ds = new ArrayDataSource<Dynamic>();
ds.add(...);
dd.dataSource = ds;
```
You can have

```haxe
var ds = new ArrayDataSource<Int>();
var ds = new ArrayDataSource<{item:String, quantity:Int}>();
ds.add(...);
dd.dataSource = ds;
```



