# 配置

您可以在 **_book.toml_** 文件中配置图书的参数.

这是一个 **_book.toml_** 文件示例，如下所示:

```toml
[book]
title = "Example book"
author = "John Doe"
description = "The example book covers examples."

[build]
build-dir = "my-example-book"
create-missing = false

[preprocessor.index]

[preprocessor.links]

[output.html]
additional-css = ["custom.css"]

[output.html.search]
limit-results = 15
```

## 支持的配置选项

重要的是要注意到，配置中指定的**任何**相对路径，都是相对于配置文件所在的书籍的根目录.

### 通用元数据

这是有关您图书的一般

| 信息            | 描述                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------ |
| **title**       | 这本书的标题                                                                               |
| **author**      | 本书的作者                                                                                 |
| **description** | 该书的描述,作为元信息,添加在每页 html 的`<head>`                                           |
| **src**         | 默认情况下,源目录位于名为`src`的目录中(在根文件夹)。但这`src`是可配置的，就在`book.toml`。 |
| **language:**   | 国家语言, 例如用在网页的 `<html lang="en">` 属性。                                         |

**book.toml**

```toml
[book]
title = "Example book"
authors = ["John Doe", "Jane Doe"]
description = "The example book covers examples."
src = "my-src"  # 源文件夹，用 `root/my-src` 替代 `root/src`
language = "zh-CN"
```

### Build 选项

这可以控制您图书的构建过程.

- **build-dir** | 放置渲染图书的目录。默认情况下在根目录的`book/`:
- **create-missing** | 默认情况(`create-missing = true`)下，在书籍建成时，会创建`SUMMARY.md`中缺失的文件。如果是`false`，则有文件不存在,那么构建过程将以错误退出。
- **use-default-preprocessors** | 设为 `false`，会禁用(`links`&`index`)的默认预处理器。

  如果您通过配置文件声明了，相同的和/或其他预处理器,由它们主导.

  - 为清楚起见,没有预处理器配置,默认`links`和`index`运行.
  - 设置`use-default-preprocessors = false`，将禁用这些默认预处理器运行.
  - 若添加`[preprocessor.links]`，那无论如何,都能确保`use-default-preprocessors`运行`links`。

## 配置,预处理器

默认情况下,以下预处理器运行，并包含:

- `links`:扩展章节中`{{ #playground }}`和`{{ #include }}`控制条，能帮助引入文件的内容.
- `index`:将所有名为`README.md`的章节文件转换`index.md`。也就是说,所有`README.md`将被渲染成`index.html`，在渲染的书中.

**book.toml**

```toml
[build]
build-dir = "build"
create-missing = false

[preprocessor.links]

[preprocessor.index]
```

### 自定义预处理器配置

与渲染器一样,预处理器需要有自己的表格(例如`[preprocessor.mathjax]`)。在该部分中,您可以通过向特有表中，添加键值对来将额外配置传递给预处理器.

例如

```toml
[preprocessor.links]
# 设置此预处理器将运行的渲染器
renderers = ["html"]
some_extra_feature = true
```

#### 锁住一个预处理依赖给一个渲染器

您可以通过将两者绑定在一起，显式指定预处理器将运行的渲染器

```toml
[preprocessor.mathjax]
renderers = ["html"]  # mathjax 只HTML渲染合作
```

### 添加你的命令

默认情况下,添加`[preprocessor.foo]`到你的`book.toml`文件,`mdbook`将尝试调用`mdbook-foo`启动。如果你想使用不同的程序名 或传递一个命令行参数。这些都能通过`command`字段覆盖完成。

```toml
[preprocessor.random]
command = "python random.py"
```

## 配置渲染器

### HTML 渲染器选项

HTML 渲染器也有几个选项,在 TOML 下指定渲染器的所有选项.

| `[output.html]`可以使用以下配置选项: | 描述                                                                                                                                       |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **theme**                            | mdBook 附带一个默认主题，及其所需的所有资源文件.但是如果设置了此选项,mdBook 将选择性地使用，能在指定文件夹中找到的主题文件，覆盖主题文件。 |
| **default-theme**                    | 默认情况下在"更改主题"下拉列表中，选择的主题颜色方案。默认为`light`。                                                                      |
| **curly-quotes**                     | 将直引号转换为反引号,除了代码块和代码 spans 中出现的引号。默认为`false`。                                                                  |
| **mathjax-support:**                 | 增加对 [MathJax](mathjax.zh.md) 的支持。 默认是                                                                                            |

`false`。
**google-analytics** | 如果您使用 Google Analytics,则可以通过在配置文件中指定 ID 来启用此选项。
**additional-css** | 如果您需要稍微更改图书的外观，而不覆盖整个样式,则可以指定一组 css 样式表,这些样式表将在默认情况下加载,这样您就通过'外科手术'更改样式。
**additional-js** | 如果您需要在不删除当前行为的情况下，向书中添加某些行为,则可以指定一组，将与默认文件一起加载的 JavaScript 文件。
**no-section-label** | 默认情况下,mdBook 在目录列中，添加章节标签编号。例如,"1.","2.1"。将此选项设置为 true 可禁用这些标签.默认为`false`。
**playpen** | 用于配置各种 playpen 设置的子表。
**search** | 用于配置浏览器内搜索功能的子表。mdBook 必须启用`search`功能编译(默认情况下已启用)。
**git-repository-url** | 这本书的 git 存储库的 URL。如果提供,将在书的菜单栏中，输出图标链接。
**git-repository-icon** | 用于 git 存储库链接的 FontAwesome 图标类。默认为`fa-github`.

---

| `[output.html.playpen]`可用的配置选项表: | 描述                                                      |
| ---------------------------------------- | --------------------------------------------------------- |
| **editable**                             | 允许编辑源代码。默认为`false`。                           |
| **copy-js**                              | 将编辑器的 JavaScript 文件，复制到输出目录。默认为`true`. |

[ace]: https://ace.c9.io/

---

| `[output.html.search]`可用的配置选项表: | 描述                                                                                                                  |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| **enable**                              | 启用搜索功能.默认为`true`。                                                                                           |
| **limit-results**                       | 搜索结果的最大数量.默认为`30`。                                                                                       |
| **teaser-word-count**                   | 搜索结果预告的单词数。默认为`30`。                                                                                    |
| **use-boolean-and**                     | 定义多个搜索词之间的逻辑链接。如果为 true,则所有搜索词必须出现在每个结果中。默认为`true`。                            |
| **boost-title**                         | 如果标题中出现搜索词,则提升搜索结果。默认为`2`。                                                                      |
| **boost-hierarchy**                     | 如果搜索结果出现在层次结构中,则提升搜索结果。层次结构包含父文档的所有标题，和所有父标题。默认为`1`。                  |
| **boost-paragraph**                     | 如果搜索词出现在文本中,则提升搜索结果。默认为`1`。                                                                    |
| **expand**                              | 默认搜索匹配更长的结果。搜索`micro`应该匹配`microwave`。默认为`true`。                                                |
| **heading-split-level**                 | 搜索结果将链接到包含结果的文档部分。文档按此级别或更低级别划分为多个部分。默认为`3`.(`### This is a level 3 heading`) |
| **copy-js**                             | 将搜索实现的 JavaScript 文件，复制到输出目录。默认为`true`.                                                           |

这显示了**book.toml**所有可用的 HTML 输出选项:

```toml
[book]
title = "Example book"
authors = ["John Doe", "Jane Doe"]
description = "The example book covers examples."

[output.html]
theme = "my-theme"
default-theme = "light"
curly-quotes = true
mathjax-support = false
google-analytics = "123456"
additional-css = ["custom.css", "custom2.css"]
additional-js = ["custom.js"]
no-section-label = false
git-repository-url = "https://github.com/rust-lang/mdBook"
git-repository-icon = "fa-github"

[output.html.playpen]
editable = false
copy-js = true

[output.html.search]
enable = true
limit-results = 30
teaser-word-count = 30
use-boolean-and = true
boost-title = 2
boost-hierarchy = 1
boost-paragraph = 1
expand = true
heading-split-level = 3
copy-js = true
```

### Markdown 渲染器

Markdown 渲染器会运行预处理器，再输出结果的
Markdown。 最大的用途就是调试预处理器, 尤其是，可以结合 `mdbook test`看到，`mdbook` 传递给`rustdoc`的 Markdown 文本。

Markdown 渲染器 已包含在 `mdbook` ，但默认禁用。
启用方式，是在`book.toml`中，添加:

```toml
[output.markdown]
```

现在还没有配置选项;
只能开和关

查看 [preprocessors 文档](#配置,预处理器) ，关于如何指定哪个 preprocessors 应在 the Markdown renderer 之前运行。

### 自定义 Renderers

可以通过添加一个`[output.foo]`表到你的`book.toml`，来启用自定义渲染器。与[preprocessors](#配置,预处理器)相似，指示`mdbook`将书的表达传递给`mdbook-foo`渲染.

自定义渲染器可以访问其表中的所有配置(即,在其`[output.foo]`下的任何内容),并且可以使用`command`字段手动指定要调用的命令.

## 环境 变量

通过设置相应的环境变量,命令行的运行，覆盖到所有配置值。因为许多操作系统将环境变量限制为`_`字母数字字符,配置字段需要格式化成，正常情况的`foo.bar.baz`形式。

变量以`MDBOOK_`开头配置。通过删除`MDBOOK_`前缀，并将结果字符串转换为`kebab-case`。双下划线(`__`)变`.` ，而单个下划线(`_`)用短划线代替(`-`).

例如:

- `MDBOOK_foo` -> `foo`
- `MDBOOK_FOO` -> `foo`
- `MDBOOK_FOO__BAR` -> `foo.bar`
- `MDBOOK_FOO_BAR` -> `foo-bar`
- `MDBOOK_FOO_bar__baz` -> `foo-bar.baz`

所以通过设置`MDBOOK_BOOK__TITLE`环境变量,你可以覆盖书的标题,而无需修改你的`book.toml`.

> **注意** 为了便于设置更复杂的配置项,首先将环境变量的值解析为 JSON,如果解析失败，则返回到字符串.
>
> 这意味着,如果您愿意,可以在构建书籍时覆盖所有书籍元数据
>
> ```shell
> $ export MDBOOK_BOOK="{'title': 'My Awesome Book', authors: ['Michael-F-Bryan']}"
> $ mdbook build
> ```

后一种情况，在以下情况下可能有用，

- 脚本或 CI 调用`mdbook`,
- 有时在构建前，无法更新`book.toml`.
