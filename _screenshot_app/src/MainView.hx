package ;

import haxe.ui.containers.VBox;
import haxe.ui.events.MouseEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
    public function new() {
        super();

        var root = tv1.addNode({text: "Root A", icon: "haxeui-core/styles/shared/folder-light.png"});
            root.expanded = true;
            root.addNode({text: "Child A-1", icon: "haxeui-core/styles/shared/warning-small.png"});
        var root = tv1.addNode({text: "Root B", icon: "haxeui-core/styles/shared/folder-light.png"});
            root.expanded = true;
            root.addNode({text: "Child B-1", icon: "haxeui-core/styles/shared/help-small.png"});
            root.addNode({text: "Child B-2", icon: "haxeui-core/styles/shared/help-small.png"});
            root.addNode({text: "Child B-3", icon: "haxeui-core/styles/shared/help-small.png"});
            root.addNode({text: "Child B-4", icon: "haxeui-core/styles/shared/help-small.png"});
    }
}