# Guide: Building HaxeUI Themes

Every HaxeUI app has a visual identity, and that identity lives in its *theme*. A theme is a package of colors, images, fonts, and style rules that tell HaxeUI how every component should look. HaxeUI ships with three built-in themes — `default`, `dark`, and `native` — but you can build your own from scratch.

This guide walks you through how themes work and how to create one. We'll keep the focus on the theme system itself rather than diving deep into every CSS property available — for that, see the [Styling Guide](https://haxeui.org/api/guides/styling.html).

## Overview

A theme is made up of three things:

| Piece | What it does | Where it lives |
|-------|-------------|----------------|
| **module.xml** | Registers your theme with HaxeUI — declares its name, its variables, and which CSS files it includes | Root of your theme package |
| **CSS files** | The actual style rules for each component | A `styles/` folder in your package |
| **Assets** | Images (nine-slice backgrounds, icons), fonts, and anything your CSS references | `images/` and/or `fonts/` folders |

When your app starts, HaxeUI's `ThemeManager` collects all the registered themes from every `module.xml` it finds (in haxeui-core, your backend, your theme package, etc.), then applies the one you've chosen. That's the whole lifecycle.

<!-- screenshot: side-by-side comparison of default theme vs dark theme vs kenney theme -->

## How the Built-In Themes Work

Before building your own, it helps to see how the ones that ship with HaxeUI are put together. Open `haxeui-core`'s `module.xml` and you'll find a `<themes>` section with three themes defined: `default`, `dark`, and `native`.

Here's the structure, simplified:

```xml
<themes>
    <global>
        <style resource="haxeui-core/styles/global.css" priority="-4" />
    </global>
    <default>
        <!-- Variables define the color palette -->
        <var name="normal-background-color-start" value="#fdfdfd" />
        <var name="normal-border-color" value="#d2d2d2" />
        <var name="normal-text-color" value="#777777" />
        <var name="accent-color" value="#83aad4" />
        <!-- ... many more ... -->

        <!-- CSS files, one per component category -->
        <style resource="haxeui-core/styles/default/main.css" priority="-3" />
        <style resource="haxeui-core/styles/default/buttons.css" />
        <style resource="haxeui-core/styles/default/checkboxes.css" />
        <!-- ... one for each component type ... -->
    </default>
    <dark parent="default">
        <!-- Only overrides what's different -->
        <var name="normal-background-color-start" value="#3e4142" />
        <var name="normal-text-color" value="#aaaaaa" />
        <!-- ... -->
        <style resource="haxeui-core/styles/dark/scrollbars.css" priority="-2" />
    </dark>
    <native parent="default">
        <style resource="haxeui-core/styles/native/main.css" priority="-3" />
    </native>
</themes>
```

A few things to notice:

- **`<global>`** is special — its styles are loaded *no matter which theme is active*. Use it for styles that should always apply.
- **`<dark parent="default">`** — the `parent` attribute means "start with everything from the default theme, then apply my overrides on top." The dark theme only needs to redefine the variables it wants to change. All the CSS files from `default` still apply.
- **Variables** (the `<var>` tags) define a color palette that CSS files reference with `$variable-name` syntax. This is the main mechanism for making themes recolorable without rewriting CSS.

## The Variable System

This is the heart of how HaxeUI theming works. Instead of hardcoding colors into CSS, the built-in stylesheets use variable references like `$normal-text-color` or `$accent-color`. When a theme is applied, HaxeUI substitutes the actual values.

For example, here's how the default theme's `buttons.css` styles a button:

```css
.button {
    background: $normal-background-color-start $normal-background-color-end vertical;
    color: $normal-text-color;
    border: $normal-border-size solid $normal-border-color;
    border-radius: $normal-border-radius;
    padding: 6px 14px;
    cursor: pointer;
}

.button:hover {
    background: $hover-background-color-start $hover-background-color-end vertical;
    color: $hover-text-color;
    border: $normal-border-size solid $hover-border-color;
}
```

Because these CSS files only reference variables, the dark theme can recolor everything just by redefining the palette — it doesn't need its own `buttons.css` at all.

Here's the complete set of variables the built-in themes define, grouped by purpose:

### Color Variables

| Variable | Purpose | Default | Dark |
|----------|---------|---------|------|
| **Normal state** | | | |
| `normal-background-color-start` | Gradient start for components | `#fdfdfd` | `#3e4142` |
| `normal-background-color-end` | Gradient end for components | `#f6f6f6` | `#36383a` |
| `normal-border-color` | Border color | `#d2d2d2` | `#222426` |
| `normal-text-color` | Default text color | `#777777` | `#aaaaaa` |
| `normal-border-size` | Border width | `1px` | `1px` |
| `normal-border-radius` | Corner rounding | `2px` | `2px` |
| **Hover state** | | | |
| `hover-background-color-start` | Hover gradient start | `#f2f2f2` | `#434647` |
| `hover-background-color-end` | Hover gradient end | `#e1e1e1` | `#393b3c` |
| `hover-text-color` | Hover text color | `#444444` | `#bbbbbb` |
| `hover-border-color` | Hover border color | `#c0c0c0` | `#222426` |
| **Down/pressed state** | | | |
| `down-background-color-start` | Pressed gradient start | `#e6e6e6` | `#393c3c` |
| `down-background-color-end` | Pressed gradient end | `#cccccc` | `#313335` |
| `down-text-color` | Pressed text color | `#444444` | `#999999` |
| `down-border-color` | Pressed border color | `#b3b3b3` | `#222426` |
| **Disabled state** | | | |
| `disabled-background-color-start` | Disabled gradient start | `#fdfdfd` | `#36393a` |
| `disabled-background-color-end` | Disabled gradient end | `#f6f6f6` | `#313335` |
| `disabled-text-color` | Disabled text color | `#cccccc` | `#595959` |
| `disabled-border-color` | Disabled border color | `#e4e4e4` | `#26292b` |
| **Selection** | | | |
| `selection-background-color` | Selected item background | `#b4cbe4` | `#415982` |
| `selection-text-color` | Selected item text | `#ffffff` | `#d4d4d4` |
| `selection-background-color-hover` | Selected + hovered | `#d9e5f2` | `#323e52` |
| **Accent** | | | |
| `accent-color` | Primary accent | `#83aad4` | `#3c5177` |
| `accent-color-darker` | Darker accent (links, etc.) | `#407dbf` | `#407dbf` |
| `accent-color-lighter` | Lighter accent | `#ecf2f9` | `#323e52` |
| **Backgrounds** | | | |
| `default-background-color` | Main background | `#ffffff` | `#2c2f30` |
| `solid-background-color` | Solid panels, sidebars | `#f6f6f6` | `#3d3f41` |
| `solid-background-color-alt` | Alternating row background | `#fafafa` | `#2d2e2f` |

### Image Variables

The built-in themes also define variables that point to image assets — arrows, checkmarks, icons, and so on. These let the dark theme swap in lighter-colored icons without changing CSS:

```xml
<!-- Default theme -->
<var name="arrow-down" value="haxeui-core/styles/shared/down-arrow-blue.png" />
<var name="check-selected" value="haxeui-core/styles/shared/check-blue.png" />
<var name="close" value="haxeui-core/styles/shared/close-button-blue.png" />

<!-- These are referenced in CSS like: -->
<!-- icon: $arrow-down; -->
```

## Two Approaches to Building a Theme

Now that you understand the system, there are two paths you can take when building your own theme:

### Approach 1: Extend an Existing Theme (Easiest)

If you want a recolored version of the default look, just override the variables. This is how the built-in `dark` theme works.

```xml
<themes>
    <my-theme parent="default">
        <!-- Your custom palette -->
        <var name="accent-color" value="#e85d04" />
        <var name="accent-color-darker" value="#dc2f02" />
        <var name="selection-background-color" value="#e85d04" />
        <var name="selection-text-color" value="#ffffff" />
        <!-- Everything else inherits from default -->
    </my-theme>
</themes>
```

That's it. Every component will pick up your new accent color automatically because the CSS files already reference these variables.

You can also add extra CSS files to override specific components on top of the inherited styles:

```xml
<my-theme parent="default">
    <var name="accent-color" value="#e85d04" />
    <!-- Override just buttons with a custom look -->
    <style resource="my-theme/styles/buttons.css" />
</my-theme>
```

### Approach 2: Build a Standalone Theme (Full Control)

If you want a completely custom look — like using nine-slice images instead of gradients — you'll build a standalone theme that doesn't inherit from `default`. This is how the [Kenney theme](https://github.com/haxeui/haxeui-theme-kenney) works.

This takes more effort, because you need to style *every* component from scratch. But it gives you total control over the visual output.

## Building a Theme Package: Step by Step

Let's build a complete, standalone theme package. We'll call it `my-theme`.

### Step 1: Create the File Structure

```
haxeui-theme-my-theme/
├── haxelib.json            # Package metadata
├── module.xml              # Theme registration
├── my-theme/
│   ├── styles/
│   │   ├── main.css        # General styles (labels, containers, layout)
│   │   ├── buttons.css     # Button styles
│   │   ├── checkboxes.css  # Checkbox styles
│   │   ├── textinputs.css  # Text field / text area styles
│   │   └── ...             # One file per component category
│   ├── images/
│   │   ├── button-normal.png
│   │   ├── button-hover.png
│   │   └── ...
│   └── fonts/
│       └── my-font.ttf
```

### Step 2: Write haxelib.json

This makes your theme installable as a Haxe library:

```json
{
    "name": "haxeui-theme-my-theme",
    "version": "1.0.0",
    "description": "A custom HaxeUI theme",
    "license": "MIT",
    "dependencies": {
        "haxeui-core": ""
    },
    "tags": ["haxeui", "ui", "theme"]
}
```

### Step 3: Write module.xml

This is where you register your theme with HaxeUI. The `<resources>` section tells HaxeUI where your files are, and the `<themes>` section defines your theme's name and what it includes.

**For a standalone theme** (no parent, full control):

```xml
<?xml version="1.0" encoding="utf-8" ?>
<module id="my-theme">
    <resources>
        <resource path="my-theme/styles" prefix="my-theme/styles" />
        <resource path="my-theme/images" prefix="my-theme/images" />
        <resource path="my-theme/fonts" prefix="my-theme/fonts" />
    </resources>
    <themes>
        <my-theme>
            <style resource="my-theme/styles/main.css" priority="-3" />
            <style resource="my-theme/styles/buttons.css" />
            <style resource="my-theme/styles/checkboxes.css" />
            <style resource="my-theme/styles/textinputs.css" />
            <!-- Add one <style> per CSS file you create -->
        </my-theme>
    </themes>
</module>
```

**For a theme that extends `default`** (inherits everything, overrides selectively):

```xml
<?xml version="1.0" encoding="utf-8" ?>
<module id="my-theme">
    <resources>
        <resource path="my-theme/styles" prefix="my-theme/styles" />
        <resource path="my-theme/images" prefix="my-theme/images" />
    </resources>
    <themes>
        <my-theme parent="default">
            <!-- Override variables -->
            <var name="accent-color" value="#e85d04" />
            <var name="normal-text-color" value="#333333" />

            <!-- Optionally add extra CSS -->
            <style resource="my-theme/styles/overrides.css" />
        </my-theme>
    </themes>
</module>
```

The key difference: a standalone theme's `<my-theme>` tag has no `parent` attribute, so it starts from nothing. An extending theme uses `parent="default"` (or `parent="dark"`, etc.) to inherit a full set of styles and variables.

### Step 4: Write Your CSS Files

Each CSS file styles a category of components. Here's a real example from the Kenney theme showing how a standalone theme uses nine-slice images for buttons instead of CSS gradients:

```css
/* buttons.css */
.button {
    cursor: pointer;
    width: auto;
    height: auto;
    spacing: 5px 5px;
    text-align: center;
    background-image: "my-theme/images/button-normal.png";
    background-image-slice: 10px 10px 39px 180px;
    padding: 12px 30px;
    color: white;
}

.button:hover {
    background-image: "my-theme/images/button-hover.png";
    background-image-slice: 10px 10px 39px 180px;
}

.button:down {
    background-image: "my-theme/images/button-pressed.png";
    background-image-slice: 10px 10px 39px 180px;
}

.button:disabled {
    opacity: 0.3;
}
```

And your `main.css` should cover the foundational components:

```css
/* main.css */

/* Containers */
.box, .vbox, .hbox, .continuoushbox, .hgrid, .vgrid, .grid {
    spacing: 5px 5px;
    width: auto;
    height: auto;
}

/* Labels */
.label {
    width: auto;
    height: auto;
    font-name: "my-theme/fonts/my-font.ttf";
}

/* Images */
.image {
    width: auto;
    height: auto;
}
```

### Step 5: Activate Your Theme

Two steps for the person using your theme:

1. Add the library to their build file (`.hxml`):

```
-lib haxeui-theme-my-theme
```

2. Set the theme in code, *before* calling `Toolkit.init()`:

```haxe
import haxe.ui.Toolkit;

class Main {
    static function main() {
        Toolkit.theme = "my-theme";
        Toolkit.init();
        // ... rest of your app
    }
}
```

That's all it takes. HaxeUI reads the `module.xml`, registers the theme, and applies it on init.

## Styling Techniques for Themes

### Nine-Slice Images

If you want a handcrafted, illustration-style look (like a game UI), you'll use nine-slice images heavily. HaxeUI supports them with two CSS properties:

```css
.button {
    background-image: "my-theme/images/button.png";
    background-image-slice: 10px 10px 39px 180px;
}
```

The `background-image-slice` property takes four values: `top right bottom left`. These define the corners that don't stretch — the center and edges stretch to fill whatever size the component needs.

### Custom Fonts

Point to a font file in your theme's `fonts/` directory:

```css
.label {
    font-name: "my-theme/fonts/my-font.ttf";
}
```

### Style Variants

You can define named variants of components using CSS class selectors. Users apply them with the `styleName` property:

```css
/* A green button variant */
.button.green {
    background-image: "my-theme/images/green-button.png";
}

/* A danger button variant */
.button.danger {
    background-image: "my-theme/images/red-button.png";
}
```

Users apply a variant in XML markup or code:

```xml
<button text="Save" styleName="green" />
<button text="Delete" styleName="danger" />
```

### Pseudo-Classes

HaxeUI components support several pseudo-classes that you should style in your theme:

| Pseudo-class | When it applies |
|-------------|-----------------|
| `:hover` | Mouse is over the component |
| `:down` | Mouse button is pressed on it |
| `:active` | Component has focus |
| `:disabled` | Component is disabled |
| `:selected` | Component is in a selected state (checkboxes, tabs, etc.) |

A thorough theme should define styles for each state on every interactive component.

### Priority

The `priority` attribute on `<style>` tags controls load order. Lower numbers load first, higher numbers load later and can override earlier styles:

```xml
<style resource="my-theme/styles/main.css" priority="-3" />  <!-- loads early -->
<style resource="my-theme/styles/buttons.css" />              <!-- default priority (0) -->
<style resource="my-theme/styles/overrides.css" priority="1" /> <!-- loads last, wins -->
```

The built-in `global.css` uses priority `-4`, and `main.css` uses `-3`, so your theme's default-priority styles will naturally override them.

## What Components Need Styling?

A complete theme should cover all of these. If you're extending `default`, you get them for free and only override what you want. If you're building standalone, you'll need to style each one:

| File | Components covered |
|------|--------------------|
| `main.css` | Containers (box, vbox, hbox, grid), labels, images, item renderers, section headers, drag/drop, modals |
| `buttons.css` | Buttons, button bars (horizontal, vertical, pill, menu variants) |
| `textinputs.css` | TextField, TextArea |
| `checkboxes.css` | CheckBox and its value/label sub-components |
| `optionboxes.css` | OptionBox (radio buttons) |
| `scrollbars.css` | Horizontal and vertical scrollbars, thumb, increment/decrement buttons |
| `scrollview.css` | ScrollView container |
| `sliders.css` | HorizontalSlider, VerticalSlider |
| `ranges.css` | HorizontalRange, VerticalRange |
| `progressbars.css` | HorizontalProgress, VerticalProgress |
| `steppers.css` | NumberStepper and variants |
| `tabs.css` | TabBar, TabView, tab buttons |
| `listview.css` | ListView and item renderers |
| `dropdowns.css` | DropDown |
| `tableview.css` | TableView, headers, columns |
| `switches.css` | Switch (default, circle, pill variants) |
| `calendars.css` | Calendar, CalendarView |
| `menus.css` | Menu, MenuBar, MenuItem |
| `dialogs.css` | Dialog, MessageBox |
| `accordion.css` | Accordion |
| `frames.css` | Frame |
| `splitters.css` | HorizontalSplitter, VerticalSplitter |
| `sidebars.css` | SideBar |
| `cards.css` | Card |
| `tooltips.css` | Tooltip |
| `treeviews.css` | TreeView |
| `propertygrids.css` | PropertyGrid |
| `colorpickers.css` | ColorPicker |
| `notifications.css` | Notifications |
| `pickers.css` | ItemPicker |
| `panels.css` | Panel |
| `windows.css` | Window, WindowTitle, WindowFooter |

That's a lot of files! This is why extending `default` is the recommended approach unless you truly need a completely different look.

## Switching Themes at Runtime

You can change the active theme while the app is running:

```haxe
// Switch to dark theme
Toolkit.theme = "dark";

// Switch to your custom theme
Toolkit.theme = "my-theme";
```

HaxeUI will clear the current stylesheet, re-apply the new theme's variables and CSS, and invalidate all components so they redraw. This happens automatically — you don't need to do anything extra.

You can also listen for theme changes if you need to react to them:

```haxe
import haxe.ui.themes.ThemeManager;
import haxe.ui.events.ThemeEvent;

ThemeManager.instance.registerEvent(
    ThemeEvent.THEME_CHANGED,
    function(e:ThemeEvent) {
        trace("Theme changed!");
    }
);
```

## Quick Reference

### module.xml Cheat Sheet

```xml
<themes>
    <!-- Standalone theme -->
    <my-theme>
        <var name="..." value="..." />
        <style resource="..." priority="0" />
    </my-theme>

    <!-- Theme that inherits from another -->
    <my-dark parent="my-theme">
        <var name="..." value="..." />
        <style resource="..." />
    </my-dark>
</themes>
```

### Activating a Theme

```haxe
Toolkit.theme = "my-theme";  // Before Toolkit.init() on startup
Toolkit.init();

Toolkit.theme = "other-theme";  // Or anytime at runtime
```

### File Structure Template

```
haxeui-theme-<name>/
├── haxelib.json
├── module.xml
└── <name>/
    ├── styles/
    │   ├── main.css
    │   ├── buttons.css
    │   └── ...
    ├── images/
    │   └── ...
    └── fonts/
        └── ...
```

## Troubleshooting

**If you see "WARNING: theme 'my-theme' not found, falling back to default theme":**
Your `module.xml` isn't being loaded. Make sure the library is added to your `.hxml` build file with `-lib haxeui-theme-my-theme`, and that the `module.xml` is at the root of the package.

**If your styles don't seem to apply:**
Check the `priority` values. A style with a lower priority will be overridden by one with a higher priority. The built-in `global.css` is at `-4` and `default/main.css` is at `-3`, so if your styles are also at `-3`, they might load before the per-component files at priority `0`. Try leaving your component CSS files at the default priority (omit the attribute).

**If images aren't showing up:**
Make sure the `<resources>` section in your `module.xml` maps the right paths. The `path` is the actual directory on disk relative to the module.xml, and `prefix` is the resource ID prefix you'll use in CSS. For example, if you have `<resource path="my-theme/images" prefix="my-theme/images" />`, then in CSS you'd write `background-image: "my-theme/images/button.png";`.

**If you want to override just one thing in the default theme:**
Use `parent="default"` and add only the variables or styles you want to change. You don't need to copy everything.
