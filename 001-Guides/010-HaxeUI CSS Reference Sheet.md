
## Implemented CSS attributes



#### Border Styles

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
|        |       |        |

Y* = with -D haxeui_extended_borders

#### List



To check the most updated version go to https://github.com/haxeui/haxeui-core/blob/master/haxe/ui/styles/Style.hx

https://github.com/haxeui/haxeui-core/blob/master/haxe/ui/styles/elements/RuleElement.hx



descriptions come https://www.tutorialrepublic.com/css-reference/css3-properties.php

| attributes                 | description                              | implementation                     |                                                              |      |
| -------------------------- | ---------------------------------------- | ---------------------------------- | ------------------------------------------------------------ | ---- |
| align*                     |                                          | NO                                 |                                                              |      |
| animation                  | Specifies the keyframe-based animations. | YES                                |                                                              |      |
| animation-delay            | Specifies when the animation will start. | YES                                |                                                              |      |
| animation-direction        |                                          | YES                                |                                                              |      |
| animation-duration         |                                          | YES                                |                                                              |      |
| animation-fill-mode        |                                          | YES                                |                                                              |      |
| animation-iteration-count  |                                          | YES                                |                                                              |      |
| animation-name             |                                          | YES                                |                                                              |      |
| animation-play-state       |                                          | NO                                 |                                                              |      |
| animation-timing-function  |                                          | YES                                |                                                              |      |
| background                 |                                          | DIFFERENT                          | In CSS3 : [ *image position/size repeat attachment origin clip color* ] <br />In HaxeUI <br />background: $normal-background-color-start $normal-background-color-end vertical; |      |
| background-attachment      |                                          | NO                                 |                                                              |      |
| background-clip            |                                          | NO (but see background-image-clip) |                                                              |      |
| background-color           |                                          | YES                                | supports rgb(), #FFFFFF,red  ,  format                       |      |
| background-image           |                                          | YES                                | doesn't support the url() format, you should directly put the link.<br /> |      |
| background-origin          |                                          |                                    |                                                              |      |
| background-position        |                                          | YES                                | You can also use `background-position-x` and `background-position-y` instead |      |
| background-repeat          |                                          | NO                                 | You can use `background-image-repeat` instead                |      |
| background-size            |                                          | NO                                 |                                                              |      |
| border                     |                                          | YES                                | `border: $normal-border-size solid $normal-border-color;`    |      |
| border-bottom              |                                          | YES                                |                                                              |      |
| border-bottom-color        |                                          | YES                                |                                                              |      |
| border-bottom-left-radius  |                                          | YES                                |                                                              |      |
| border-bottom-right-radius |                                          | YES                                |                                                              |      |
| border-bottom-style        |                                          | NO                                 |                                                              |      |
| border-bottom-width        |                                          | YES                                |                                                              |      |
| border-collapse            |                                          | NO                                 |                                                              |      |
| border-color               |                                          | NO                                 |                                                              |      |
| border-image*              |                                          | NO                                 |                                                              |      |
| border-left                |                                          | YES                                |                                                              |      |
| border-left-color          |                                          | YES                                |                                                              |      |
| border-left-style          |                                          | NO                                 |                                                              |      |
| border-left-width          |                                          | YES                                |                                                              |      |
| border-radius              |                                          | YES                                |                                                              |      |
| border-spacing             |                                          | NO                                 |                                                              |      |
| border-style               |                                          | YES                                |                                                              |      |
| border-width               |                                          | NO                                 | use  border or border-left-width                             |      |
| bottom                     |                                          | NO                                 |                                                              |      |
| box-shadow                 |                                          | YES                                | (supported on html)                                          |      |
| box-sizing                 |                                          | NO                                 |                                                              |      |
| caption-side               |                                          | NO                                 |                                                              |      |
| clear                      |                                          | NO                                 |                                                              |      |
| clip                       |                                          | YES                                | A little bit different, in CSS you set to a region, in haxeUI, you just set it to true .<br />HaxeUI will clip the component's children so it doesn't exceed component's height and width.  It's to be used sparingly. |      |
| color                      |                                          | YES                                |                                                              |      |
| column*                    |                                          | NO                                 | You can use code . Maybe it  should be included for column counts. |      |
| content                    |                                          | NO                                 |                                                              |      |
| counter                    |                                          | NO                                 |                                                              |      |
| cursor                     |                                          | YES                                |                                                              |      |
| direction                  |                                          | ?different                         |                                                              |      |
| display                    |                                          | USED                               | see haxe ui layout <br />In haxe ui , display is equivalent of hidden |      |
| empty-cells                |                                          | NO                                 |                                                              |      |
| flex*                      |                                          | NO                                 |                                                              |      |
| float                      |                                          | NO                                 |                                                              |      |
| font                       |                                          | NO                                 |                                                              |      |
| font-family                |                                          | YES                                |                                                              |      |
| font-size                  |                                          | YES                                |                                                              |      |
| font-size_adjust           |                                          | NO                                 |                                                              |      |
| font-stretch               |                                          | NO                                 |                                                              |      |
| font-style                 |                                          | YES                                |                                                              |      |
| font-variant               |                                          | NO                                 |                                                              |      |
| font-weight                |                                          | NO                                 |                                                              |      |
| height                     |                                          | YES                                |                                                              |      |
| justify-content            |                                          | NO                                 |                                                              |      |
| left                       |                                          | YES                                |                                                              |      |
| letter-spacing             |                                          | NO                                 |                                                              |      |
| line-height                |                                          | NO                                 |                                                              |      |
| list*                      |                                          | NO                                 |                                                              |      |
| margin                     |                                          |                                    |                                                              |      |
| margin-bottom              |                                          | YES                                |                                                              |      |
| max-height                 |                                          | YES                                |                                                              |      |
| max-width                  |                                          | YES                                |                                                              |      |
| min-height                 |                                          | YES                                |                                                              |      |
| min-width                  |                                          | YES                                |                                                              |      |
| opacity                    |                                          | YES                                |                                                              |      |
| order                      |                                          | NO                                 |                                                              |      |
| outline*                   |                                          | NO                                 |                                                              |      |
| overflow*                  |                                          | NO                                 |                                                              |      |
| padding                    |                                          | YES                                |                                                              |      |
| page-break*                |                                          | NO                                 |                                                              |      |
| perspective*               |                                          | NO                                 |                                                              |      |
| quotes                     |                                          | NO                                 |                                                              |      |
| resize                     |                                          | NO                                 |                                                              |      |
| right                      |                                          | NO                                 |                                                              |      |
| tab-size                   |                                          | NO                                 |                                                              |      |
| table-layout               |                                          | NO                                 |                                                              |      |
| text-align                 |                                          | YES                                |                                                              |      |
| text-align-last            |                                          | NO                                 |                                                              |      |
| text-decoration            |                                          | YES                                |                                                              |      |
| text-decoration-*          |                                          | NO                                 |                                                              |      |
| text-*                     |                                          | NO                                 |                                                              |      |
| top                        |                                          | YES                                |                                                              |      |
| transform*                 |                                          | NO                                 |                                                              |      |
| transition*                |                                          | NO                                 |                                                              |      |
| vertical-align             |                                          | YES                                |                                                              |      |
| visibility                 |                                          | NO                                 |                                                              |      |
| white-space                |                                          | NO                                 |                                                              |      |
| width                      |                                          | YES                                |                                                              |      |
| word-break                 |                                          | NO                                 |                                                              |      |
| word-spacing               |                                          | NO                                 |                                                              |      |
| word-wrap                  |                                          | YES                                |                                                              |      |
| z-index                    |                                          | NO                                 |                                                              |      |
|                            |                                          |                                    |                                                              |      |

## HaxeUI Only CSS

| attribute                  | description                                                  | example |
| -------------------------- | ------------------------------------------------------------ | ------- |
| horizontal-spacing         | the horizontal spacing between children                      |         |
| vertical-spacing           | the vertical spacing between children                        |         |
| background-color           |                                                              |         |
| background-color-end       |                                                              |         |
| background-gradient-style  |                                                              |         |
| background-opacity         |                                                              |         |
| background-position-x      |                                                              |         |
| background-position-y      |                                                              |         |
| background-image-clip-top  |                                                              |         |
| background-image-slice-top |                                                              |         |
| border-top-size            | same as border-top-width                                     |         |
| border-top-left-radius     |                                                              |         |
| border-opacity             |                                                              |         |
| icon                       | the image ressource for the button                           |         |
| icon-position              | where the icon is placed for a button : left, top, right, bottom |         |
|                            |                                                              |         |
| font-bold                  |                                                              |         |
| font-underline             |                                                              |         |
| font-italic                |                                                              |         |
| font-style                 |                                                              |         |
|                            |                                                              |         |
| hidden                     | if the component is hidden or not                            |         |
| display                    | if the component is  not hidden                              |         |
| native                     |                                                              |         |
| filter                     |                                                              |         |
| backdrop-filter            |                                                              |         |
| resource                   |                                                              |         |
| mode                       | for now only mode="mobile" for difference in mobile behaviour in dropdown components |         |
| content-type               | auto, html, or other   for textfield / areas                 |         |
| content-height             | height of the children inside the container                  |         |
| image-rendering            | for openfl "pixelated"                                       |         |
| layout                     | layout: classic  for steppers, <br />vertical for boxes , etc |         |
| pointer-events             |                                                              |         |
| spacing                    | the spacing between the children                             |         |
|                            |                                                              |         |



## Making responsive design with @media

using @media



https://github.com/haxeui/haxeui-core/blob/02663d838e5c175b39fd966570a74d1acbc6147f/haxe/ui/styles/elements/MediaQuery.hx#L6

https://github.com/haxeui/component-examples/blob/master/responsive/assets/main.css
