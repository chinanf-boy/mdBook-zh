# index.hbs

`index.hbs`是用于渲染书籍的 hbs 模板。markdown 文件被处理为 html,然后注入该模板.

如果您想更改图书的布局或样式,您可能需要稍微修改此模板。那下面是你需要知道的。

## Data

大量数据通过"上下文"暴露给 hbs 模板.在 hbs 模板中,您可以使用以下方式访问此信息

```handlebars
{{name_of_property}}
```

以下是公开的属性列表:

- **language** |> 书的语言`en`。例如`<code class="language-html">\\<html lang="{{ language }}"></code>`。
- **title** |> 该书的标题，如`book.toml`中所述
- **chapter_title** |> 当前章节的标题，格式是 `{{ chapter_title }} - {{ book_title }}`，除非 unless `book_title` 没有设置，这种情况下，默认为 `chapter_title`。
- **path** |> 源目录中原始 markdown 文件的相对路径
- **content** |> 这是渲染的 markdown.
- **path_to_root** |> 这是一条完全包含`../`的路径，这会是从当前文件指向书的根。由于维护了原始目录结构，因此使用此前缀相对链接很有用.
- **chapters** |> 是一个字典数组

```json
{
  "section": "1.2.1",
  "name": "name of this chapter",
  "path": "dir/markdown.md"
}
```

包含本书的所有章节.它用于例如构建目录(侧边栏).

## Handlebars 帮手

除了您可以访问的属性外,您还可以使用一些 hbs 帮手.

### 1. toc

````
toc助手就像这样使用

```handlebars
{{#toc}}{{/toc}}
```

并输出看起来像这样的东西，这取决于你的书的结构

```html
<ul class="chapter">
    <li><a href="link/to/file.html">Some chapter</a></li>
    <li>
        <ul class="section">
            <li><a href="link/to/other_file.html">Some other Chapter</a></li>
        </ul>
    </li>
</ul>
```

如果您想使用其他结构创建一个toc，则可以访问包含所有数据的chapters属性。
目前唯一的限制是您必须使用JavaScript,而不是使用hbs帮助程序。

```html
<script>
var chapters = {{chapters}};
// Processing here
</script>
```
````

### 2. previous / next

````
上一个和下一个助手将`link`和`name`属性暴露给前一章和下一章。

就像这样使用

```handlebars
{{#previous}}
    <a href="{{link}}" class="nav-chapters previous">
        <i class="fa fa-angle-left"></i>
    </a>
{{/previous}}
```

只有在前一个/下一个章节存在时,才会渲染内部html。
当然内部html可以根据自己的喜好进行更改。
````

---

_如果您希望其他属性或帮手,请[create a new
issue](https://github.com/rust-lang/mdBook/issues)_
