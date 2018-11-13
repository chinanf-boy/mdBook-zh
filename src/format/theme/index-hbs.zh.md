# index.hbs

`index.hbs`是用于渲染书籍的把手模板.markdown文件被处理为html,然后注入该模板.

如果您想更改图书的布局或样式,您可能需要稍微修改此模板.这是你需要知道的.

## Data

大量数据通过"上下文"暴露给车把模板.在把手模板中,您可以使用以下方式访问此信息

```handlebars
{{name_of_property}}
```

以下是公开的属性列表:

-   ***语言***表格中的书的语言`en`.用于<code
    class="language-html">\\<html lang="{{ language }}"></code>例如.目前它是硬编码的.
-   ***标题***该书的标题,如中所述`book.toml`
-   ***chapter_title***本章的标题,如下所列`SUMMARY.md`

-   ***路径***源目录中原始markdown文件的相对路径
-   ***内容***这是渲染的markdown.
-   ***path_to_root***这是一条完全包含的路径`../`这是从当前文件指向书的根.由于维护了原始目录结构,因此使用此前缀相对链接很有用`path_to_root`.

-   ***章***是一个表单的字典数组
    ```json
    {"section": "1.2.1", "name": "name of this chapter", "path": "dir/markdown.md"}
    ```
    包含本书的所有章节.它用于例如构建目录(侧边栏).

## Handlebars Helpers

除了您可以访问的属性外,您还可以使用一些把手帮手.

### 1. toc

````
The toc helper is used like this

```handlebars
{{#toc}}{{/toc}}
```

and outputs something that looks like this, depending on the structure of your book

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

If you would like to make a toc with another structure, you have access to the chapters property containing all the data.
The only limitation at the moment is that you would have to do it with JavaScript instead of with a handlebars helper.

```html
<script>
var chapters = {{chapters}};
// Processing here
</script>
```
````

### 2. previous / next

````
The previous and next helpers expose a `link` and `name` property to the previous and next chapters.

They are used like this

```handlebars
{{#previous}}
    <a href="{{link}}" class="nav-chapters previous">
        <i class="fa fa-angle-left"></i>
    </a>
{{/previous}}
```

The inner html will only be rendered if the previous / next chapter exists.
Of course the inner html can be changed to your liking.
````

* * *

*如果您希望其他房产或佣工曝光,请[create a new
issue](https://github.com/rust-lang-nursery/mdBook/issues)*
