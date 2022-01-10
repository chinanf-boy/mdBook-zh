## 配置渲染器

渲染器（也叫后端），职责是书的输出。

内置的渲染器有:

- [`html`](#html-renderer-options) — HTML 的输出.
  默认启动， 如果 `book.toml` 上的`[output]`，没有其他设置。
- [`markdown`](#markdown-renderer) — 运行 预处理器之后，输出 markdown。
  调试专用。

社区也有，可以看看 [Third Party Plugins] 。

开发的话，看这里 [Backends for Developers] 。

[third party plugins]: https://github.com/rust-lang/mdBook/wiki/Third-party-plugins
[backends for developers]: ../../for_developers/backends.zh.md

## Output tables

Backends 通过 `book.toml` 的`output` 设置，记得带上名称。
比如：它叫做 `mdbook-wordcount`, 写入:

```toml
[output.wordcount]
```

有了这个设置， mdBook 会执行 `mdbook-wordcount` 后端。

还能添加额外的配置参数，例如：
如果我们 wordcount 需要其他的配置选项：

```toml
[output.wordcount]
ignores = ["Example Chapter"]
```

如果，定义了任意的 `[output]`，那么 `html` 就不会启动。
如果你想 `html` 在后台运行，请写入 `book.toml` 文件。
For example:

```toml
[book]
title = "My Awesome Book"

[output.wordcount]

[output.html]
```

如果定义`output`，超过一个 ，那么这会，改变输出目录的布局。
如果只有一个后端，那么，输出目录就在 `book` 目录 (配置 [`build.build-dir`]，覆盖位置)。
如果超过一个后端，那么，就会放在 `book`下，分开的目录。
例如：上面的命令就会有 `book/html` 和 `book/wordcount`。

[`build.build-dir`]: general.zh.md#build-options

### Custom backend commands

默认情况下，将 `[output.foo]` 添加到 `book.toml` 文件，
`mdbook` 会尝试调用 `mdbook-foo` 可执行文件。
如果，你使用了一个不同的程序名称，或传递命令行参数，这些行为都会被 `command` 覆盖。

```toml
[output.random]
command = "python random.py"
```

### Optional backends

如果你的后端是没有安装的，那么默认的行为就是抛出一个错误。
这个错误的纠正，可以将后端设为可选：

```toml
[output.wordcount]
optional = true
```

这会将 错误，变成警告。

### HTML 渲染器选项

HTML 渲染器也有几个选项，在 TOML 下指定渲染器的所有选项.

```toml
# Example book.toml file with all output options.
[book]
title = "Example book"
authors = ["John Doe", "Jane Doe"]
description = "The example book covers examples."

[output.html]
theme = "my-theme"
default-theme = "light"
preferred-dark-theme = "navy"
curly-quotes = true
mathjax-support = false
copy-fonts = true
additional-css = ["custom.css", "custom2.css"]
additional-js = ["custom.js"]
no-section-label = false
git-repository-url = "https://github.com/rust-lang/mdBook"
git-repository-icon = "fa-github"
edit-url-template = "https://github.com/rust-lang/mdBook/edit/master/guide/{path}"
site-url = "/example-book/"
cname = "myproject.rs"
input-404 = "not-found.md"
```

| `[output.html]`可以使用以下配置选项: | 描述                                                                                                                                                                                                                                                                                                                           |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| **theme**                            | mdBook 附带一个默认主题，及其所需的所有资源文件.但是如果设置了此选项,mdBook 将选择性地使用，能在指定文件夹中找到的主题文件，覆盖主题文件。                                                                                                                                                                                     |
| **default-theme**                    | 默认情况下在"更改主题"下拉列表中，选择的主题颜色方案。默认为`light`。                                                                                                                                                                                                                                                          |
| **preferred-dark-theme:**            | 默认 dark 主题。如果要求 dark 主题，通过 ['prefers-color-scheme'](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme) CSS 媒体查询，就是网站的 dark 版本 。 默认是 `navy`。                                                                                                                          |
| **curly-quotes**                     | 将直引号转换为反引号,除了代码块和代码 spans 中出现的引号。默认为`false`。                                                                                                                                                                                                                                                      |
| **copy-fonts:**                      | 复制 fonts.css 和 各自 font 文件到输出目录，和在默认主题使用它们。 默认为`true`。                                                                                                                                                                                                                                              |
| **mathjax-support:**                 | 增加对 [MathJax](mathjax.zh.md) 的支持。 默认是`false`。                                                                                                                                                                                                                                                                       |
| **google-analytics**                 | 如果您使用 Google Analytics,则可以通过在配置文件中指定 ID 来启用此选项。                                                                                                                                                                                                                                                       |
| **additional-css**                   | 如果您需要稍微更改图书的外观，而不覆盖整个样式,则可以指定一组 css 样式表,这些样式表将在默认情况下加载,这样您就通过'外科手术'更改样式。                                                                                                                                                                                         |
| **additional-js**                    | 如果您需要在不删除当前行为的情况下，向书中添加某些行为,则可以指定一组，将与默认文件一起加载的 JavaScript 文件。                                                                                                                                                                                                                |
| **no-section-label**                 | 默认情况下,mdBook 在目录列中，添加章节标签编号。例如,"1.","2.1"。将此选项设置为 true 可禁用这些标签.默认为`false`。                                                                                                                                                                                                            |     |
| **git-repository-url**               | 这本书的 git 存储库的 URL。如果提供,将在书的菜单栏中，输出图标链接。                                                                                                                                                                                                                                                           |
| **git-repository-icon**              | 用于 git 存储库链接的 FontAwesome 图标类。默认为`fa-github`。看起来就像 <i class="fa fa-github"></i>。                                                                                                                                                                                                                         |
| **edit-url-template:**               | 编辑按钮, 提供 "编辑" 按钮 (看起来就像 <i class="fa fa-edit"></i>) ，方便定位到源代码的文档文件。例如：如果你是 Github 项目，设为 `https://github.com/<owner>/<repo>/edit/master/{path}` 或是 Bitbucket 项目，设为 `https://bitbucket.org/<owner>/<repo>/src/master/{path}?mode=edit` ，其中的 {path} 自然要修改成你的项目路径 |
| **input-404:**                       | 404 要展示的文件，文件后缀会换成 `html`。 默认为`404.md`。                                                                                                                                                                                                                                                                     |
| **site-url:**                        | 主页网址。确保网页的链接 和 script/css 为正确路径。默认为`/`。                                                                                                                                                                                                                                                                 |
| **cname:**                           | DNS 子域名 或是 apex 域名 。写入根目录下的 CNAME 文件中，就像 GitHub Pages 的 CNAME 一样 ( [_管理你 GitHub Pages 的域名_][custom domain]).                                                                                                                                                                                     |

[custom domain]: https://docs.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site

### `[output.html.print]`

`[output.html.print]` 定义打印式输出.
默认情况下，mdBook 给出打印按钮 (看起来就像 <i class="fa fa-print"></i>) ，将打印单页。

```toml
[output.html.print]
enable = true    # 添加打印功能
```

- **enable:** 启用打印。 默认为`true`。

### `[output.html.fold]`

`[output.html.fold]` 能控制导航栏的折叠。

```toml
[output.html.fold]
enable = false    # whether or not to enable section folding
level = 0         # the depth to start folding
```

- **enable:** 默认是`false`。
- **level:** 开启折叠的层级。level 如果是 0, 全部折叠。默认为`0`。

---

### `[output.html.playground]`

`[output.html.playground]` 提供导入 Rust 代码，和与 [Rust Playground] 集成的功能。

[rust playground]: https://play.rust-lang.org/

```toml
[output.html.playground]
editable = false         # allows editing the source code
copyable = true          # include the copy button for copying code snippets
copy-js = true           # includes the JavaScript for the code editor
line-numbers = false     # displays line numbers for editable code
```

| `[output.html.playground]`可用的配置选项表: | 描述                                                                 |
| ------------------------------------------- | -------------------------------------------------------------------- |
| **editable**                                | 允许编辑源代码。默认为`false`。                                      |
| **copyable:**                               | 复制按钮，默认为 `true`。                                            |
| **copy-js**                                 | 将编辑器的 JavaScript 文件，复制到输出目录。默认为`true`。           |
| **line-numbers**                            | 显示行数，要求 `editable` 和 `copy-js` 都为 `true`。默认为 `false`。 |

[ace]: https://ace.c9.io/

### `[output.html.search]`

`[output.html.search]` 控制 [search] 的配置。
mdBook 需要 `search` 功能开启 (默认就有)。

[search]: ../../guide/reading.md#search

```toml
[output.html.search]
enable = true            # enables the search feature
limit-results = 30       # maximum number of search results
teaser-word-count = 30   # number of words used for a search result teaser
use-boolean-and = true   # multiple search terms must all match
boost-title = 2          # ranking boost factor for matches in headers
boost-hierarchy = 1      # ranking boost factor for matches in page names
boost-paragraph = 1      # ranking boost factor for matches in text
expand = true            # partial words will match longer terms
heading-split-level = 3  # link results to heading levels
copy-js = true           # include Javascript code for search
```

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
| **copy-js**                             | 将搜索实现的 JavaScript 文件，复制到输出目录。默认为`true`。                                                          |

### `[output.html.redirect]`

`[output.html.redirect]` 添加跳转
用于你对一个页面的移动，重命名，移除，确保旧链接，跳转到新位置。

```toml
[output.html.redirect]
"/appendices/bibliography.html" = "https://rustc-dev-guide.rust-lang.org/appendix/bibliography.html"
"/other-installation-methods.html" = "../infra/other-installation-methods.html"
```

key-value 格式，key 是需要跳转文件，来自构建目录的绝对路径。 (例如： `/appendices/bibliography.html`).
将要跳转到的位置 (例如：`https://rust-lang.org/`, `/overview.html`, or `../bibliography.html`).

生成跳转到新位置的 HTML 页面。
注意，是不支持 `#` 的网络链接定位的。

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
