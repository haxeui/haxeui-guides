# Guide: Working with HaxeUI

This guide covers the day-to-day of building interfaces with HaxeUI. You'll learn how to describe your UI with XML markup, style it with CSS, and — when you need to — build and manipulate components from Haxe code. By the end, you'll have a solid feel for the workflow and know which approach to reach for in different situations.

## The Big Picture

HaxeUI gives you three ways to define your interface:

| Approach | What it looks like | Best for |
|----------|--------------------|----------|
| **XML + CSS** | Declarative markup and stylesheets | Laying out screens, forms, and most everyday UI work |
| **Haxe code** | Constructing components with `new Button()`, etc. | Dynamic UI built at runtime, procedural generation |
| **Mixed** | XML for structure, code for behavior | Most real-world apps |

Most of the time, you'll use **XML to define what's on screen** and **CSS to define how it looks**. Then you'll write Haxe code to handle events and update things at runtime. That's the sweet spot, and it's what this guide focuses on.

## Part 1: Building UI with XML

### Your First Layout

Here's a complete, minimal XML layout — two buttons side by side:

```xml
<hbox>
    <button text="Hello" />
    <button text="World" />
</hbox>
```

That's it. The `<hbox>` is a *container* (a component that arranges children inside it) — specifically one that lays out its children horizontally. Each `<button>` becomes a HaxeUI `Button` component. The `text` attribute sets the button's label.

<!-- screenshot: two buttons side by side labeled "Hello" and "World" -->

### Loading XML into Your App

The most common way to use XML layouts in HaxeUI is to **bind them to a component class**. You save your XML as a file and connect it to a Haxe class with the `@:build` macro:

**assets/main-view.xml:**
```xml
<vbox style="padding: 5px;">
    <hbox>
        <button text="Hello" id="helloButton" />
        <button text="World" id="worldButton" />
    </hbox>
</vbox>
```

**MainView.hx:**
```haxe
import haxe.ui.containers.VBox;
import haxe.ui.events.MouseEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
    public function new() {
        super();
        helloButton.onClick = function(e) {
            helloButton.text = "Clicked!";
        }
    }
}
```

The `@:build` macro reads your XML at compile-time and does two things: it generates the component tree from your markup, and it creates **typed fields** for every component that has an `id`. So `helloButton` is a real `Button` field on your class — you get full autocomplete and type checking in your editor.

Then in your main entry point, you just create an instance and add it to the screen:

```haxe
import haxe.ui.Toolkit;

class Main {
    static function main() {
        Toolkit.init();
        Toolkit.screen.addComponent(new MainView());
    }
}
```

This is how most HaxeUI apps are structured — each screen, panel, or reusable widget is a class with its own XML layout file.

### Inline XML with `@:xml`

For smaller components — or when you'd rather keep the layout right next to the code — you can embed XML directly on a class with the `@:xml` metadata:

```haxe
@:xml('
<hbox>
    <image id="linkIcon" verticalAlign="center" hidden="true" />
    <link id="link" verticalAlign="center" />
</hbox>
')
class IconLink extends HBox {
    public override function set_text(value:String):String {
        link.text = value;
        link.show();
        return value;
    }
}
```

This works exactly like `@:build` — components with `id` attributes become typed fields on the class. It's the same pattern HaxeUI uses internally to build its own composite components like `Panel`, `Window`, and `IconLink`.

`@:xml` is great for small, self-contained components where having a separate XML file feels like overkill. For larger layouts, an external file with `@:build` keeps things easier to read.

### One-Off Loading with `ComponentBuilder.fromFile`

Occasionally, you just want to load a piece of XML without creating a dedicated class for it — maybe for a quick prototype, a dynamically chosen layout, or a simple app entry point:

```haxe
var view = ComponentBuilder.fromFile("assets/main-view.xml");
Toolkit.screen.addComponent(view);
```

This is a compile-time macro, so there's no runtime XML parsing overhead. However, you'll need to use `findComponent()` to access anything inside the layout, which is less convenient than the typed fields you get with `@:build` or `@:xml`. For anything beyond a quick prototype, binding to a class is the better path.

All XML loading in HaxeUI happens at **compile-time** — the XML is parsed by macros and turned into efficient Haxe code. There's no runtime XML parser involved.

### How XML Tags Map to Components

Every XML tag maps to a HaxeUI class. The tag name is just the class name in lowercase:

| XML tag | HaxeUI class | What it is |
|---------|-------------|------------|
| `<button>` | `haxe.ui.components.Button` | A clickable button |
| `<label>` | `haxe.ui.components.Label` | A text label |
| `<textfield>` | `haxe.ui.components.TextField` | A single-line text input |
| `<textarea>` | `haxe.ui.components.TextArea` | A multi-line text input |
| `<checkbox>` | `haxe.ui.components.CheckBox` | A toggleable checkbox |
| `<slider>` | `haxe.ui.components.Slider` | A draggable slider |
| `<image>` | `haxe.ui.components.Image` | An image display |
| `<dropdown>` | `haxe.ui.components.DropDown` | A dropdown selector |
| `<vbox>` | `haxe.ui.containers.VBox` | Vertical layout container |
| `<hbox>` | `haxe.ui.containers.HBox` | Horizontal layout container |
| `<grid>` | `haxe.ui.containers.Grid` | Grid layout container |
| `<scrollview>` | `haxe.ui.containers.ScrollView` | Scrollable content area |
| `<tabview>` | `haxe.ui.containers.TabView` | Tabbed container |
| `<accordion>` | `haxe.ui.containers.Accordion` | Collapsible sections |

The general rule: container tags hold other components inside them, component tags are the leaf-level UI elements.

### Setting Properties with Attributes

XML attributes map directly to component properties. HaxeUI automatically converts the string values to the right types:

```xml
<button text="Save"
        width="200"
        disabled="true"
        icon="assets/save-icon.png" />
```

That's equivalent to writing in Haxe:

```haxe
var button = new Button();
button.text = "Save";
button.width = 200;
button.disabled = true;
button.icon = "assets/save-icon.png";
```

A few common attributes that work on all components:

| Attribute | Type | What it does |
|-----------|------|-------------|
| `id` | String | Gives the component a name you can reference from code |
| `width` / `height` | Number | Fixed size in pixels |
| `percentWidth` / `percentHeight` | Number | Size as a percentage of the parent (0-100) |
| `style` | String | Inline CSS styles |
| `styleNames` | String | CSS class names to apply (space-separated) |
| `disabled` | Bool | Disables the component |
| `tooltip` | String | Hover tooltip text |
| `hidden` | Bool | Hides the component |

### Percentage Sizing

One of the most useful layout tricks is percentage-based sizing. Instead of hardcoding pixel widths, you tell a component to fill a percentage of its parent:

```xml
<vbox percentWidth="100" percentHeight="100" style="padding: 10px;">
    <label text="Full-width label" percentWidth="100" />
    <hbox percentWidth="100">
        <button text="Left" percentWidth="50" />
        <button text="Right" percentWidth="50" />
    </hbox>
</vbox>
```

<!-- screenshot: a full-width label above two buttons each taking half the width -->

This creates a layout that adapts to whatever size its parent is. The outer `<vbox>` fills 100% of the available space, the label stretches to the full width, and the two buttons each take half.

> **Common pitfall:** `percentWidth` and `percentHeight` calculate a percentage *of the parent's size*. If the parent doesn't have a defined size — either a fixed `width`/`height`, its own `percentWidth`/`percentHeight`, or being added to the screen (which provides the initial size) — the math has nothing to work with and the component won't size correctly. If your percentage-sized component isn't showing up, work your way up the tree and make sure every parent has a known size.

### Nesting Containers

You build complex layouts by nesting containers. Here's a settings panel with a header, a form area, and action buttons at the bottom:

```xml
<vbox percentWidth="100" percentHeight="100" style="padding: 10px;">
    <label text="Settings" styleNames="section-header" />

    <scrollview percentWidth="100" percentHeight="100">
        <vbox percentWidth="100">
            <hbox percentWidth="100">
                <label text="Username" width="120" />
                <textfield percentWidth="100" />
            </hbox>
            <hbox percentWidth="100">
                <label text="Email" width="120" />
                <textfield percentWidth="100" />
            </hbox>
            <hbox percentWidth="100">
                <label text="Theme" width="120" />
                <dropdown percentWidth="100" />
            </hbox>
            <checkbox text="Enable notifications" />
            <checkbox text="Dark mode" />
        </vbox>
    </scrollview>

    <hbox>
        <spacer percentWidth="100" />
        <button text="Cancel" />
        <button text="Save" styleNames="emphasized" />
    </hbox>
</vbox>
```

<!-- screenshot: a settings panel with labeled form fields, checkboxes, and save/cancel buttons -->

A few things to notice:

- The `<scrollview>` makes the form area scrollable if it gets too tall
- The `<spacer>` with `percentWidth="100"` pushes the buttons to the right
- Nesting an `<hbox>` inside a `<vbox>` gives you rows within a vertical layout

### Giving Components IDs

When you need to reference a component from Haxe code — to read its value, change its text, or listen for events — give it an `id`:

```xml
<vbox style="padding: 10px;">
    <textfield id="nameInput" text="World" />
    <button id="greetButton" text="Greet" />
    <label id="output" text="" />
</vbox>
```

Then in Haxe, you can find these components by their ID:

```haxe
var view = ComponentBuilder.fromFile("assets/my-view.xml");

var nameInput = view.findComponent("nameInput", TextField);
var greetButton = view.findComponent("greetButton", Button);
var output = view.findComponent("output", Label);

greetButton.registerEvent(MouseEvent.CLICK, function(e) {
    output.text = "Hello, " + nameInput.text + "!";
});
```

### Inline Event Handlers

For quick interactions, you can handle events directly in XML with `onclick` (and similar attributes):

```xml
<button text="Click Me!" onclick="this.text = 'Thanks!'" />
```

The expression inside `onclick` is Haxe code. `this` refers to the component itself. You can also reference other components by their `id`:

```xml
<hbox>
    <textfield id="counter" text="0" />
    <button text="-" onclick="counter.text = '' + (Std.parseInt(counter.text) - 1)" />
    <button text="+" onclick="counter.text = '' + (Std.parseInt(counter.text) + 1)" />
</hbox>
```

<!-- screenshot: a text field showing "0" with minus and plus buttons -->

This is handy for prototyping and simple interactions. For anything more complex, you'll want to handle events in Haxe code instead.

### Embedding Styles in XML

You can include a `<style>` block directly in your XML to define CSS rules that apply to that layout:

```xml
<vbox style="padding: 10px;">
    <style>
        .big-button {
            font-size: 20px;
            padding: 12px 24px;
        }

        .warning-text {
            color: #cc3333;
            font-bold: true;
        }
    </style>

    <button text="Large Button" styleNames="big-button" />
    <label text="Something went wrong" styleNames="warning-text" />
</vbox>
```

Apply the class names with the `styleNames` attribute. You can apply multiple classes separated by spaces: `styleNames="big-button warning-text"`.

---

## Part 2: Styling with CSS

HaxeUI uses a CSS-like stylesheet system. If you've written CSS for the web, most of it will feel familiar — but there are some differences worth knowing about.

### Selectors

HaxeUI supports these selector types:

```css
/* By component type (lowercase class name) */
.button {
    padding: 10px;
}

/* By style class */
.my-custom-style {
    color: #ff0000;
}

/* By ID */
#saveButton {
    font-bold: true;
}

/* Descendant selector (button inside a vbox) */
.vbox .button {
    percentWidth: 100;
}

/* Pseudo-classes */
.button:hover {
    background-color: #e0e0e0;
}

.button:disabled {
    opacity: 0.3;
}
```

### Pseudo-Classes

These are the pseudo-classes HaxeUI components respond to:

| Pseudo-class | When it applies |
|-------------|-----------------|
| `:hover` | Mouse is over the component |
| `:down` | Mouse button is held down on it |
| `:active` | Component has keyboard focus |
| `:disabled` | Component is disabled |
| `:selected` | Component is in a selected state (checkboxes, toggle buttons, tabs) |

A well-styled component defines rules for each interactive state:

```css
.my-button {
    background-color: #4a90d9;
    color: #ffffff;
    border: 1px solid #3a7bc8;
    border-radius: 4px;
    padding: 8px 16px;
    cursor: pointer;
}

.my-button:hover {
    background-color: #5a9fe9;
    border-color: #4a8fd8;
}

.my-button:down {
    background-color: #3a80c9;
}

.my-button:disabled {
    background-color: #cccccc;
    color: #888888;
    cursor: default;
}
```

### CSS Properties

HaxeUI supports a large set of CSS properties. Here are the ones you'll use most often:

**Sizing and Layout**

| CSS property | What it does | Example |
|-------------|-------------|---------|
| `width` / `height` | Fixed size in pixels | `width: 200px;` |
| `percent-width` / `percent-height` | Size as percentage of parent | `percent-width: 50%;` |
| `min-width` / `max-width` | Size constraints | `min-width: 100px;` |
| `padding` | Space inside the component | `padding: 10px;` |
| `padding-top`, `-left`, `-right`, `-bottom` | Per-side padding | `padding-left: 20px;` |
| `margin-top`, `-left`, `-right`, `-bottom` | Offset from calculated position | `margin-top: 5px;` |
| `spacing` | Gap between children (shorthand: `horizontal vertical`) | `spacing: 5px 10px;` |
| `horizontal-spacing` / `vertical-spacing` | Gap between children | `horizontal-spacing: 5px;` |

**Backgrounds**

| CSS property | What it does | Example |
|-------------|-------------|---------|
| `background-color` | Solid fill color | `background-color: #ffffff;` |
| `background` | Gradient (start end direction) | `background: #ffffff #eeeeee vertical;` |
| `background-image` | Image background | `background-image: "assets/bg.png";` |
| `background-image-slice` | Nine-slice regions (top right bottom left) | `background-image-slice: 10px 10px 10px 10px;` |
| `background-opacity` | Background transparency (0-1) | `background-opacity: 0.5;` |

**Borders**

| CSS property | What it does | Example |
|-------------|-------------|---------|
| `border` | Shorthand (size style color) | `border: 1px solid #cccccc;` |
| `border-color` | Border color (all sides) | `border-color: #333333;` |
| `border-top-color`, etc. | Per-side border color | `border-left-color: #ff0000;` |
| `border-size` | Border width (all sides) | `border-size: 2px;` |
| `border-top-size`, etc. | Per-side border width | `border-bottom-size: 3px;` |
| `border-radius` | Corner rounding (all corners) | `border-radius: 6px;` |
| `border-top-left-radius`, etc. | Per-corner rounding | `border-top-left-radius: 10px;` |

**Text**

| CSS property | What it does | Example |
|-------------|-------------|---------|
| `color` | Text color | `color: #333333;` |
| `font-size` | Text size in pixels | `font-size: 16px;` |
| `font-name` | Font file path | `font-name: "assets/my-font.ttf";` |
| `font-bold` | Bold text | `font-bold: true;` |
| `font-italic` | Italic text | `font-italic: true;` |
| `font-underline` | Underlined text | `font-underline: true;` |
| `text-align` | Horizontal text alignment | `text-align: center;` |
| `word-wrap` | Wrap long text | `word-wrap: true;` |

**Appearance**

| CSS property | What it does | Example |
|-------------|-------------|---------|
| `opacity` | Overall transparency (0-1) | `opacity: 0.5;` |
| `cursor` | Mouse cursor style | `cursor: pointer;` |
| `hidden` | Hide the component | `hidden: true;` |
| `clip` | Clip children to bounds | `clip: true;` |
| `icon` | Icon image path | `icon: "assets/icon.png";` |
| `icon-position` | Icon placement | `icon-position: "left";` |

**Alignment**

| CSS property | What it does | Example |
|-------------|-------------|---------|
| `horizontal-align` | Horizontal position within parent | `horizontal-align: center;` |
| `vertical-align` | Vertical position within parent | `vertical-align: center;` |

### Theme Variables

HaxeUI's built-in stylesheets use variables prefixed with `$`. You can reference these in your own CSS to stay consistent with the active theme:

```css
.my-panel {
    background-color: $default-background-color;
    color: $normal-text-color;
    border: 1px solid $normal-border-color;
}

.my-panel:hover {
    border-color: $accent-color;
}
```

When the user switches themes (say, from `default` to `dark`), your panel will automatically pick up the new colors. See the [Building Themes](https://haxeui.org/api/guides/themes.html) guide.

### CSS Functions

HaxeUI supports several CSS functions that are useful for responsive layouts:

```css
.sidebar {
    /* Math */
    width: calc(100% - 250px);

    /* Constraints */
    height: min(500px, 100%);
    padding: clamp(5px, 2%, 20px);

    /* Color manipulation */
    background-color: lighten(#333333, 20);
    border-color: darken(#ffffff, 10);
}
```

| Function | What it does | Example |
|----------|-------------|---------|
| `calc()` | Arithmetic on values | `calc(100% - 20px)` |
| `min()` | Smaller of two values | `min(300px, 50%)` |
| `max()` | Larger of two values | `max(100px, 50%)` |
| `clamp()` | Value within a range | `clamp(5px, 10%, 50px)` |
| `lighten()` | Lighten a color | `lighten(#333, 20)` |
| `darken()` | Darken a color | `darken(#fff, 10)` |
| `rgb()` | Color from RGB values | `rgb(255, 100, 50)` |

> **Note:** The `calc()` function requires the `hscript` library to be available in your project (`-lib hscript` in your `.hxml` file). The other functions — `min`, `max`, `clamp`, `lighten`, `darken`, `rgb` — work without it.

### Filters

You can apply visual filters to any component:

```css
.popup {
    filter: drop-shadow(2, 45, #000000, 0.15, 6, 1, 30, 35, false);
}

.blurred-background {
    filter: blur(3);
}

.disabled-image {
    filter: grayscale;
    opacity: 0.5;
}
```

Available filters: `blur`, `drop-shadow`, `box-shadow`, `grayscale`, `tint`, `contrast`, `brightness`, `saturate`, `hue-rotate`, `invert`, `outline`.

### Animations

HaxeUI supports CSS keyframe animations:

```css
@keyframes fadeIn {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}

.fade-in {
    animation: fadeIn 0.3s ease 0s 1;
}
```

The `animation` shorthand is: `name duration easing delay iterations [direction] [fillmode]`.

### Where to Put Your CSS

You have a few options:

**1. Inline on a component** — for one-off tweaks:
```xml
<button text="Save" style="font-size: 18px; font-bold: true;" />
```

**2. In a `<style>` block in XML** — for styles used across a single layout:
```xml
<vbox>
    <style>
        .form-label { width: 120px; vertical-align: center; }
    </style>
    <hbox>
        <label text="Name" styleNames="form-label" />
        <textfield percentWidth="100" />
    </hbox>
</vbox>
```

**3. In your theme** — for app-wide styles. See the [Building Themes](https://haxeui.org/api/guides/themes.html) guide.

**4. At runtime from code** — for dynamic styles:
```haxe
Toolkit.styleSheet.parse("
    .highlight { background-color: #ffffcc; border: 1px solid #ffcc00; }
");
```

---

## Part 3: Connecting XML to Code

The XML defines what's on screen, but your Haxe code brings it to life — handling events, reading values, and updating the UI. Here's how the two sides connect.

### The `@:build` Pattern (Recommended)

This is how most HaxeUI apps work in practice. You define your layout in an XML file, then bind it to a Haxe class:

**assets/login-form.xml:**
```xml
<vbox percentWidth="100" style="padding: 20px;">
    <label text="Log In" style="font-size: 20px; font-bold: true;" />
    <textfield id="usernameInput" placeholder="Username" percentWidth="100" />
    <textfield id="passwordInput" placeholder="Password" password="true" percentWidth="100" />
    <button id="submitButton" text="Log In" />
    <label id="statusLabel" text="" />
</vbox>
```

**LoginForm.hx:**
```haxe
import haxe.ui.containers.VBox;
import haxe.ui.events.MouseEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/login-form.xml"))
class LoginForm extends VBox {
    public function new() {
        super();
        submitButton.onClick = function(e) {
            statusLabel.text = "Logging in as " + usernameInput.text + "...";
        }
    }
}
```

Every component in the XML that has an `id` becomes a **typed field** on the class. `usernameInput` is a real `TextField`, `submitButton` is a real `Button` — you get autocomplete, type safety, and compile-time error checking.

### The `@:xml` Pattern (Inline)

For smaller components where a separate file feels like overkill, embed the XML directly on the class:

```haxe
import haxe.ui.containers.HBox;
import haxe.ui.components.Button;

@:xml('
<hbox style="spacing: 5px;">
    <button id="decrementButton" text="-" />
    <label id="counterLabel" text="0" style="vertical-align: center; width: 40px; text-align: center;" />
    <button id="incrementButton" text="+" />
</hbox>
')
class Counter extends HBox {
    private var count:Int = 0;

    public function new() {
        super();
        decrementButton.onClick = function(e) {
            count--;
            counterLabel.text = Std.string(count);
        }
        incrementButton.onClick = function(e) {
            count++;
            counterLabel.text = Std.string(count);
        }
    }
}
```

This is the same pattern HaxeUI uses internally — components like `Panel`, `Window`, and `IconLink` all use `@:xml` to define their internal structure.

### The `@:bind` Shorthand

Instead of wiring up event listeners manually in the constructor, you can use `@:bind` to connect a method directly to a component's event:

```haxe
@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
    public function new() {
        super();
    }

    @:bind(submitButton, MouseEvent.CLICK)
    private function onSubmit(e:MouseEvent) {
        statusLabel.text = "Submitted!";
    }
}
```

The `@:bind` metadata takes the component field name and the event type. HaxeUI wires the connection at compile-time.

### Registering Events

Whether your components come from XML or code, events work the same way:

```haxe
import haxe.ui.events.MouseEvent;
import haxe.ui.events.UIEvent;

// Click handler
button.registerEvent(MouseEvent.CLICK, function(e:MouseEvent) {
    trace("Clicked at " + e.screenX + ", " + e.screenY);
});

// Value changed (text fields, sliders, checkboxes, etc.)
slider.registerEvent(UIEvent.CHANGE, function(e:UIEvent) {
    trace("New value: " + slider.pos);
});

// Or use the shorthand property
button.onClick = function(e) {
    trace("Clicked!");
}
```

The main event types:

| Event class | Common types | Used for |
|-------------|-------------|----------|
| `MouseEvent` | `CLICK`, `MOUSE_DOWN`, `MOUSE_UP`, `MOUSE_OVER`, `MOUSE_OUT`, `DBL_CLICK`, `RIGHT_CLICK` | Mouse interactions |
| `UIEvent` | `CHANGE`, `READY`, `RESIZE`, `SHOWN`, `HIDDEN` | Component state changes |
| `KeyboardEvent` | `KEY_DOWN`, `KEY_UP`, `KEY_PRESS` | Keyboard input |

### Finding Components

If you need to look up a component at runtime (for example, one loaded via `fromFile` that doesn't have typed fields):

```haxe
// Find by ID (searches recursively by default)
var button = root.findComponent("saveButton", Button);

// Find all components of a type
var allButtons = root.findComponents(null, Button);
```

With `@:build` or `@:xml`, you usually don't need `findComponent` — the typed fields are more convenient and catch mistakes at compile-time.

### Setting Styles from Code

You can modify a component's style programmatically when you need to:

```haxe
button.customStyle.backgroundColor = 0xFF0000;
button.customStyle.color = 0xFFFFFF;
button.customStyle.borderRadius = 8;
button.invalidateComponentStyle();  // apply the changes
```

Or add/remove CSS class names:

```haxe
button.addClass("highlight");
button.removeClass("highlight");
```

In general, it's better to define styles in CSS and toggle class names rather than setting individual style properties in code. This keeps your visual design in one place.

### Creating Components Purely from Code

Sometimes you need to build UI dynamically — generating a list from data, or assembling a layout based on runtime conditions. You can construct any HaxeUI component directly:

```haxe
import haxe.ui.components.Button;
import haxe.ui.components.Label;
import haxe.ui.containers.VBox;

// Build a list of items from data
var list = new VBox();
for (item in dataItems) {
    var label = new Label();
    label.text = item.name;
    list.addComponent(label);
}
container.addComponent(list);
```

This is useful for the truly dynamic parts of your UI. But for anything with a known structure — a form, a settings panel, a dialog — XML is clearer and easier to maintain. Compare the code above to the XML equivalent and you'll see why:

```xml
<!-- This is immediately readable. The code version, less so. -->
<vbox>
    <label text="Item 1" />
    <label text="Item 2" />
    <label text="Item 3" />
</vbox>
```

The code API is there when you need it, but XML + CSS should be your default.

### Managing Children

When you are working with components in code:

```haxe
// Add a component
container.addComponent(child);

// Add at a specific position
container.addComponentAt(child, 0);  // insert at the beginning

// Remove a component
container.removeComponent(child);

// Remove by index
container.removeComponentAt(2);

// Check how many children
var count = container.numComponents;

// Get all children
var children = container.childComponents;
```

---

## Part 4: The Recommended Workflow

Most HaxeUI apps follow the same pattern, and it works well:

1. **XML** defines the structure of each screen, panel, or reusable component
2. **CSS** handles all the visual styling — either in `<style>` blocks within XML, or in your theme
3. **A Haxe class** (`@:build` or `@:xml`) owns each piece of UI, wiring up event handlers and managing state
4. **Pure code construction** is reserved for the genuinely dynamic parts — building lists from data, conditional UI, procedural generation

This gives you the readability of declarative markup, the type safety and power of Haxe, and clean separation between structure, style, and behavior.

### When you might use code-only construction

- **Truly dynamic UI.** A list of items from a database, a form generated from a schema — things where the structure isn't known at compile time.
- **Programmatic animation or effects.** Sometimes it's easier to create and manipulate components in a loop.
- **Quick experiments.** If you're testing something in a few lines of code and don't want to set up a file.

But even in these cases, the component that *hosts* the dynamic content is usually defined in XML. For example, you might have a `<scrollview id="messageList" />` in your XML layout, and then add `Label` components to `messageList` from code as messages arrive.

---

## Quick Reference

### Binding XML to a Class

```haxe
// External XML file (most common)
@:build(haxe.ui.ComponentBuilder.build("assets/my-view.xml"))
class MyView extends VBox {
    public function new() {
        super();
        // id'd components are typed fields: myButton, myInput, etc.
    }
}

// Inline XML (good for small components)
@:xml('
<hbox>
    <button id="myButton" text="Click" />
    <label id="myLabel" text="Hello" />
</hbox>
')
class MyWidget extends HBox { }

// One-off loading (quick prototypes only)
var view = ComponentBuilder.fromFile("assets/my-view.xml");
```

### Common XML Patterns

```xml
<!-- Vertical stack with spacing -->
<vbox style="spacing: 10px; padding: 10px;">
    <label text="Title" />
    <button text="Action" />
</vbox>

<!-- Horizontal row, children centered -->
<hbox style="vertical-align: center; spacing: 5px;">
    <image resource="icon.png" />
    <label text="Label next to icon" />
</hbox>

<!-- Full-width component -->
<textfield percentWidth="100" placeholder="Type here..." />

<!-- Right-aligned buttons -->
<hbox>
    <spacer percentWidth="100" />
    <button text="Cancel" />
    <button text="OK" />
</hbox>

<!-- Grid layout (columns attribute sets column count) -->
<grid columns="2" style="spacing: 5px;">
    <label text="Name" />
    <textfield percentWidth="100" />
    <label text="Email" />
    <textfield percentWidth="100" />
</grid>
```

### Common CSS Patterns

```css
/* Card-style panel */
.card {
    background-color: $default-background-color;
    border: 1px solid $normal-border-color;
    border-radius: 6px;
    padding: 16px;
    filter: drop-shadow(2, 45, #000000, 0.1, 4, 1, 1, 3, false);
}

/* Full-width form field */
.form-row {
    percent-width: 100;
}

.form-row .label {
    width: 120px;
    vertical-align: center;
}

.form-row .textfield {
    percent-width: 100;
}

/* Responsive text */
.title {
    font-size: 24px;
    font-bold: true;
    color: $normal-text-color;
}

.subtitle {
    font-size: 14px;
    color: $lighter-text-color;
}
```

### Event Handling

```haxe
// Shorthand property (simplest)
myButton.onClick = function(e) { };

// @:bind on a class method (cleanest for @:build classes)
@:bind(myButton, MouseEvent.CLICK)
private function onMyButton(e:MouseEvent) { }

// registerEvent (most flexible)
component.registerEvent(MouseEvent.CLICK, function(e:MouseEvent) { });
component.registerEvent(UIEvent.CHANGE, function(e:UIEvent) { });
component.registerEvent(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) { });
```

## Troubleshooting

**If your layout doesn't appear:**
Make sure you called `Toolkit.init()` before creating any components, and that you added your root component to `Toolkit.screen.addComponent(view)`.

**If percentWidth/percentHeight doesn't work:**
Every parent in the chain needs a known size — see the [Percentage Sizing](#percentage-sizing) section above. Work your way up the tree and make sure each container has either a fixed size, its own percentage size, or is added directly to the screen.

**If styles don't apply:**
Check that the selector matches. Component type selectors use lowercase: `.button`, not `.Button`. Make sure `styleNames` on the component matches your CSS class name (without the dot).

**If `findComponent` returns null:**
Double-check the `id` in your XML. The search is case-sensitive. Also make sure the component has been created — if you're calling `findComponent` in a constructor before `super()`, the XML layout hasn't been built yet.

**If inline XML events don't fire:**
The `onclick`, `onchange`, etc. attributes expect Haxe expressions. Make sure strings are properly quoted inside the attribute: `onclick="this.text = 'clicked'"` (single quotes inside double quotes).
