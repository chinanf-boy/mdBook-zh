# Theme

默认渲染器使用一个[handlebars](http://handlebarsjs.com/)模板，用于渲染 markdown 文件,并 mdBook 二进制文件包含默认主题.

主题是完全可定制的,您可以通过在根目录`src`旁边，新建一个`theme`文件夹，在其中选择性地添加文件名称，覆盖主题的任意文件。

| 以下是您可以覆盖的文件:   | 描述                                                      |
| ------------------------- | --------------------------------------------------------- |
| **index.hbs**             | hbs 模板.                                                 |
| **_head.hbs_**            | HTML `<head>` 部分.                                       |
| **_header.hbs_**          | 每个页面的头部                                            |
| - **_css/_**              | 样式文件                                                  |
| - **_css/chrome.css_**    | UI 元素                                                   |
| - **_css/general.css_**   | 基础样式                                                  |
| - **_css/print.css_**     | 打印输出的样式                                            |
| - **_css/variables.css_** | css 变量                                                  |
| **book.js**               | 主要用于添加客户端功能,如隐藏/取消隐藏侧边栏,更改主题,... |
| **highlight.js**          | 是用于突出显示代码片段的 JavaScript,您不需要修改它.       |
| **highlight.css**         | 是用于代码突出显示的主题                                  |
| **favicon.svg**           | 将使用的 favicon                                          |

通常,当您想要调整主题时,您不需要覆盖所有文件。如果您只需要更改 css 样式表,那么覆盖所有其他文件是没有意义的。由于自定义文件优先于内置文件，那以后的新的修补程序/功能，你都更新不了。

**注意:** 覆盖文件时,可能会破坏某些功能。因此,我建议使用默认主题中的文件作为模板,只添加/修改您需要的内容。您可以使用`mdbook init --theme`命令自动将默认主题自动复制到源目录中，只需删除您不想覆盖的文件。

`mdbook init --theme` 不会创建上面所提到的文件。
比如 `head.hbs`文件，是没有同等（示例）文件。
所以，你需要自行完成创建。

如果你想完全替换内置主题，请在
[`output.html.preferred-dark-theme`]设置，不然默认还是 `navy` 主题

[`output.html.preferred-dark-theme`]: ../configuration/renderers.zh.md#html-renderer-options
[newer browsers]: https://caniuse.com/#feat=link-icon-svg
