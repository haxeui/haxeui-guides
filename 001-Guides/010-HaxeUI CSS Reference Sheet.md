# CSS Reference

## Attributes

To check the most updated list (which is just the source code), go to [Style.hx](https://github.com/haxeui/haxeui-core/blob/master/haxe/ui/styles/Style.hx) and [RuleElement.hx](https://github.com/haxeui/haxeui-core/blob/master/haxe/ui/styles/elements/RuleElement.hx).

Some descriptions come from https://www.tutorialrepublic.com/css-reference/css3-properties.php.

| attribute                  | description                              | implementation                     | notes                                                        |
| -------------------------- | ---------------------------------------- | ---------------------------------- | ------------------------------------------------------------ |
| animation                  | Specifies the keyframe-based animations. | YES                                |                                                              |
| animation-delay            | Specifies when the animation will start. | YES                                |                                                              |
| animation-direction        |                                          | YES                                |                                                              |
| animation-duration         |                                          | YES                                |                                                              |
| animation-fill-mode        |                                          | YES                                |                                                              |
| animation-iteration-count  |                                          | YES                                |                                                              |
| animation-name             |                                          | YES                                |                                                              |
| animation-timing-function  |                                          | YES                                |                                                              |
| backdrop-filter            |                                          | HaxeUI ONLY                        |                                                              |
| background                 |                                          | DIFFERENT                          | In CSS3 : [ *image position/size repeat attachment origin clip color* ] <br />In HaxeUI <br />background: $normal-background-color-start $normal-background-color-end vertical; |
| background-color           |                                          | YES                                | Supports "rgb()", "#FFFFFF" & "red" formats                  |
| background-color-end       |                                          | HaxeUI ONLY                        |                                                              |
| background-gradient-style  |                                          | HaxeUI ONLY                        |                                                              |
| background-image           |                                          | YES                                | Doesn't support the url() format, you should directly put the link. |
| background-image-clip-top  |                                          | HaxeUI ONLY                        |                                                              |
| background-image-slice-top |                                          | HaxeUI ONLY                        |                                                              |
| background-opacity         |                                          | HaxeUI ONLY                        |                                                              |
| background-position        |                                          | YES                                | You can also use `background-position-x` and `background-position-y` instead. |
| background-position-x      |                                          | HaxeUI ONLY                        |                                                              |
| background-position-y      |                                          | HaxeUI ONLY                        |                                                              |
| border                     |                                          | YES                                | `border: $normal-border-size solid $normal-border-color;`    |
| border-bottom              |                                          | YES                                |                                                              |
| border-bottom-color        |                                          | YES                                |                                                              |
| border-bottom-left-radius  |                                          | YES                                |                                                              |
| border-bottom-right-radius |                                          | YES                                |                                                              |
| border-bottom-width        |                                          | YES                                |                                                              |
| border-left                |                                          | YES                                |                                                              |
| border-left-color          |                                          | YES                                |                                                              |
| border-left-width          |                                          | YES                                |                                                              |
| border-opacity             |                                          | HaxeUI ONLY                        |                                                              |
| border-radius              |                                          | YES                                |                                                              |
| border-style               |                                          | YES                                |                                                              |
| border-top-left-radius     |                                          | HaxeUI ONLY                        |                                                              |
| border-top-size            | Same as `border-top-width`.              | HaxeUI ONLY                        |                                                              |
| box-shadow                 |                                          | DIFFERENT                          | Available as a filter (`filter: box-shadow;`).               |
| clip                       |                                          | YES                                | A little bit different, in CSS you set it to a region, in HaxeUI, you just set it to true.<br />HaxeUI will clip the component's children so it doesn't exceed the parent's width and height. It's to be used sparingly. |
| color                      |                                          | YES                                |                                                              |
| content-height             | Height of the children inside the container.                  | HaxeUI ONLY                        |                                                              |
| content-type               | "auto", "html" or other. Used for Label, TextField & TextArea.                 | HaxeUI ONLY                        |                                                              |
| cursor                     |                                          | YES                                |                                                              |
| direction                  |                                          | DIFFERENT                          |                                                              |
| display                    |                                          | DIFFERENT                          | In HaxeUI , `display` is equivalent to  `hidden`.            |
| filter                     |                                          | HaxeUI ONLY                        |                                                              |
| font-bold                  |                                          | HaxeUI ONLY                        |                                                              |
| font-family                |                                          | YES                                |                                                              |
| font-italic                |                                          | HaxeUI ONLY                        |                                                              |
| font-size                  |                                          | YES                                |                                                              |
| font-style                 |                                          | YES                                |                                                              |
| font-underline             |                                          | HaxeUI ONLY                        |                                                              |
| height                     |                                          | YES                                |                                                              |
| hidden                     | If the component is hidden or not.       | HaxeUI ONLY                        |                                                              |
| horizontal-spacing         | The horizontal spacing between children. | HaxeUI ONLY                        |                                                              |
| image-rendering            | Set to "pixelated" to decrease the drawing quality.                                       | HaxeUI ONLY                        |                                                              |
| icon                       | The image resource for the icon.         | HaxeUI ONLY                        |                                                              |
| icon-position              | Where the icon is placed: "left", "top", "right", or "bottom". | HaxeUI ONLY                        |                                                              |
| include-in-layout          | Whether this component should be taken into account when calculating the parent's size or applying its layout. | HaxeUI ONLY                        |                                                              |
| layout                     | Specify a custom layout for components.  | HaxeUI ONLY                        |                                                              |
| left                       |                                          | YES                                |                                                              |
| margin-bottom              |                                          | YES                                |                                                              |
| max-height                 |                                          | YES                                |                                                              |
| max-width                  |                                          | YES                                |                                                              |
| min-height                 |                                          | YES                                |                                                              |
| min-width                  |                                          | YES                                |                                                              |
| mode                       | For now only used as `mode="mobile"` for difference in mobile behaviour in dropdown components. | HaxeUI Only                        |                                                              |
| native                     |                                          | HaxeUI Only                        |                                                              |
| opacity                    |                                          | YES                                |                                                              |
| padding                    |                                          | YES                                |                                                              |
| pointer-events             |                                          | HaxeUI Only                        |                                                              |
| resource                   |                                          | HaxeUI Only                        |                                                              |
| spacing                    | The spacing between the children.        | HaxeUI Only                        |                                                              |
| text-align                 |                                          | YES                                |                                                              |
| text-decoration            |                                          | YES                                |                                                              |
| top                        |                                          | YES                                |                                                              |
| vertical-align             |                                          | YES                                |                                                              |
| vertical-spacing           | The vertical spacing between children.   | HaxeUI ONLY                        |                                                              |
| width                      |                                          | YES                                |                                                              |
| word-wrap                  |                                          | YES                                |                                                              |

### Unimplemented attributes

| attribute                  | notes                                                       |
| -------------------------- | ----------------------------------------------------------- |
| align                      | You can use `horizontal-align` and `vertical-align` instead |
| animation-play-state       |                                                             |
| background-attachment      |                                                             |
| background-clip            | You can use `background-image-clip` instead                 |
| background-origin          |                                                             |
| background-repeat          | You can use `background-image-repeat` instead               |
| background-size            |                                                             |
| border-bottom-style        |                                                             |
| border-collapse            |                                                             |
| border-color               |                                                             |
| border-image               |                                                             |
| border-left-style          |                                                             |
| border-spacing             |                                                             |
| border-width               | You can use `border-width` or `border-left-width`           |
| bottom                     |                                                             |
| box-sizing                 |                                                             |
| caption-side               |                                                             |
| clear                      |                                                             |
| column                     | You can use code                                            |
| content                    |                                                             |
| counter                    |                                                             |
| empty-cells                |                                                             |
| flex                       |                                                             |
| float                      |                                                             |
| font                       |                                                             |
| font-size_adjust           |                                                             |
| font-stretch               |                                                             |
| font-variant               |                                                             |
| font-weight                |                                                             |
| justify-content            |                                                             |
| letter-spacing             |                                                             |
| line-height                |                                                             |
| list                       |                                                             |
| margin                     |                                                             |
| order                      |                                                             |
| outline                    |                                                             |
| overflow                   |                                                             |
| page-break                 |                                                             |
| perspective                |                                                             |
| quotes                     |                                                             |
| resize                     |                                                             |
| right                      |                                                             |
| tab-size                   |                                                             |
| table-layout               |                                                             |
| text-align-last            |                                                             |
| text-decoration-*          |                                                             |
| text-*                     |                                                             |
| transform                  |                                                             |
| transition                 |                                                             |
| visibility                 |                                                             |
| white-space                |                                                             |
| word-break                 |                                                             |
| word-spacing               |                                                             |
| z-index                    |                                                             |

## Border Styles

It depends on the platform.

|        | html5 | openfl |
| ------ | ----- | ------ |
| none   | Y     | Y      |
| hidden | Y     | N      |
| dotted | Y     | Y*     |
| dashed | Y     | Y*     |
| solid  | Y     | Y      |
| double | Y     | Y*     |
| groove | Y     | N      |
| ridge  | Y     | N      |
| inset  | Y     | N      |
| outset | Y     | N      |

Y* = with -D haxeui_extended_borders

## Making responsive design with @media

Using @media: [MediaQuery.hx](https://github.com/haxeui/haxeui-core/blob/master/haxe/ui/styles/elements/MediaQuery.hx), [Example CSS](https://github.com/haxeui/component-examples/blob/original/responsive/assets/main.css)
