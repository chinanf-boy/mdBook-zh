# rust-lang-nursery/mdBook [![explain]][source] [![translate-svg]][translate-list]

<!-- [![size-img]][size] -->

[explain]: http://llever.com/explain.svg
[source]: https://github.com/chinanf-boy/Source-Explain
[translate-svg]: http://llever.com/translate.svg
[translate-list]: https://github.com/chinanf-boy/chinese-translate-list
[size-img]: https://packagephobia.now.sh/badge?p=Name
[size]: https://packagephobia.now.sh/result?p=Name

「 一个从 Markdown 文件，创建现代在线书籍的实用程序 」

[中文](./readme.md) | [english](https://github.com/rust-lang-nursery/mdBook)

---

## 校对 🀄️

<!-- doc-templite START generated -->
<!-- repo = 'rust-lang-nursery/mdBook' -->
<!-- commit = '42b87e0fbc6815ae2177a5fc4838dad11a33fe4f' -->
<!-- time = '2018-10-30' -->

| 翻译的原文 | 与日期        | 最新更新 | 更多                       |
| ---------- | ------------- | -------- | -------------------------- |
| [commit]   | ⏰ 2018-10-30 | ![last]  | [中文翻译][translate-list] |

[last]: https://img.shields.io/github/last-commit/rust-lang-nursery/mdBook.svg
[commit]: https://github.com/rust-lang-nursery/mdBook/tree/42b87e0fbc6815ae2177a5fc4838dad11a33fe4f

<!-- doc-templite END generated -->

- [ ] readme
- [x] [SUMMARY.md](./src/SUMMARY.md)
- [ ] [mdbook](./src/README.zh.md)
- [ ] [命令行工具](./src/cli/README.zh.md)
  - [ ] [init](./src/cli/init.zh.md)
  - [ ] [build](./src/cli/build.zh.md)
  - [ ] [watch](./src/cli/watch.zh.md)
  - [ ] [serve](./src/cli/serve.zh.md)
  - [ ] [test](./src/cli/test.zh.md)
  - [ ] [clean](./src/cli/clean.zh.md)
- [ ] [格式](./src/format/README.zh.md)
  - [ ] [SUMMARY.md](./src/format/summary.zh.md)
  - [ ] [配置](./src/format/config.zh.md)
  - [ ] [Theme-主题](./src/format/theme/README.zh.md)
    - [ ] [index.hbs](./src/format/theme/index-hbs.zh.md)
    - [ ] [语法高亮显示](./src/format/theme/syntax-highlighting.zh.md)
    - [ ] [编辑器](./src/format/theme/editor.zh.md)
  - [ ] [MathJax 支持](./src/format/mathjax.zh.md)
  - [ ] [mdBook 特殊功能](./src/format/mdbook.zh.md)
- [ ] [持续集成](./src/continuous-integration.zh.md)
- [ ] [对开发者说](./src/for_developers/README.zh.md)
  - [ ] [预处理程序](./src/for_developers/preprocessors.zh.md)
  - [ ] [备用后端](./src/for_developers/backends.zh.md)

---

- [ ] [贡献者](misc/contributors.zh.md)

### 贡献

欢迎 👏 勘误/校对/更新贡献 😊 [具体贡献请看](https://github.com/chinanf-boy/chinese-translate-list#贡献)

## 生活

[help me live , live need money 💰](https://github.com/chinanf-boy/live-need-money)

---

# mdBook

<table>
    <tr>
        <td><strong>Linux / OS X</strong></td>
        <td>
            <a href="https://travis-ci.org/rust-lang-nursery/mdBook"><img src="https://travis-ci.org/rust-lang-nursery/mdBook.svg?branch=master"></a>
        </td>
    </tr>
    <tr>
        <td><strong>Windows</strong></td>
        <td>
            <a href="https://ci.appveyor.com/project/rust-lang-libs/mdbook"><img src="https://ci.appveyor.com/api/projects/status/ysyke2rvo85sni55?svg=true"></a>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <a href="https://crates.io/crates/mdbook"><img src="https://img.shields.io/crates/v/mdbook.svg"></a>
            <a href="LICENSE"><img src="https://img.shields.io/github/license/rust-lang-nursery/mdBook.svg"></a>
        </td>
    </tr>
</table>

mdBook 是一个从 Markdown 文件创建现代在线书籍的实用程序.

### 目录

<!-- START doctoc -->
<!-- END doctoc -->

## 它是什么样子的?

该[用户指南]对于 mdBook 已经用 Markdown 编写,并且正在使用 mdBook 生成您可以阅读的在线书籍式网站.该文档使用 GitHub 上的最新版本并展示了可用的功能.

## 安装

有多种方法可以安装 mdBook.

1.  **二进制**

    二进制文件可供下载[这里][releases].确保将二进制文件的路径放入您的`PATH`.

2.  **来自 Crates.io**

    这至少需要[锈]1.20 和货物安装.安装 Rust 后,在终端中键入以下内容:

    ```
    cargo install mdbook
    ```

    这将为您下载并编译 mdBook,剩下要做的就是将 Cargo bin 目录添加到您的`PATH`.

    **注意自动部署**

    如果您使用脚本使用 Travis 或其他 CI 服务器进行自动部署,我们建议您在通过脚本安装 mdBook 时为 mdBook 指定 semver 版本范围!

    这将限制服务器安装最新版本**非破**mdBook 的版本,因为我们发布了新版本,因此会阻止您的图书无法构建.例如:

    ```
    cargo install mdbook --vers "^0.1.0"
    ```

3.  **来自 Git**

    发布到 crates.io 的版本将略微落后于 GitHub 上托管的版本.如果您需要最新版本,可以自己构建 mdBook 的 git 版本.货物就是这样**_超级容易_**!

    ```
    cargo install --git https://github.com/rust-lang-nursery/mdBook.git mdbook
    ```

    再次确保将 Cargo bin 目录添加到您的`PATH`.

4.  **对于贡献**

    如果您想为 mdBook 做贡献,您必须在本地计算机上克隆存储库:

    ```
    git clone https://github.com/rust-lang-nursery/mdBook.git
    ```

    `cd`成`mdBook/`并运行

    ```
    cargo build
    ```

    生成的二进制文件可以在中找到`mdBook/target/debug/`以...之名`mdBook`要么`mdBook.exe`.

## 用法

mdBook 将主要用作命令行工具,即使它将其所有功能公开为 Rust crate 以便在其他项目中集成.

以下是您要运行的主要命令.有关更详尽的解释,请查看[用户指南].

- `mdbook init`

  init 命令将创建一个目录,其中包含最小的样板文件.

  ```
  book-test/
  ├── book
  └── src
      ├── chapter_1.md
      └── SUMMARY.md
  ```

  `book`和`src`都是目录.`src`包含将用于将输出呈现给的标记文件`book`目录.

  请看看[CLI 文档]了解更多信息和一些巧妙的技巧.

- `mdbook build`

  这是您将用于渲染图书的命令,​​ 它会读取`SUMMARY.md`用于了解图书结构的文件,将源目录中的 markdown 文件作为输入,并输出可以上传到服务器的静态 html 页面.

- `mdbook watch`

  运行此命令时,mdbook 将监视您的 markdown 文件,以便在每次更改时重建本书.这避免了必须返回终端进行打字`mdbook build`一遍又一遍地.

- `mdbook serve`

  做同样的事情`mdbook watch`但另外还提供了这本书`http://localhost:3000`(端口可更改)并在发生更改时重新加载浏览器.

- `mdbook clean`

  删除生成的书籍所在的目录.

### 第三方插件

用户可以通过第三方插件配置书籍的加载和呈现方式.这些插件只是在构建过程中调用的程序,大致分为两类,*预处理器*和*渲染器*.

预处理器用于在将书籍发送到渲染器之前对其进行转换.一个例子是替换所有出现的`{{#include some_file.ext}}`与该文件的内容.一些现有的预处理器是:

- `index`- 一个内置的预处理器(默认启用),它将转换所有`README.md`章节`index.md`所以`foo/README.md`可以通过网址访问`foo/`发布到浏览器时
- `links`- 内置预处理器(默认启用),用于扩展`{{# playpen}}`和`{{# include}}`帮助者在一章中.

渲染器将 ​​ 获得最终的书籍,以便他们可以使用它.顾名思义,这通常用于以特定格式呈现文档,但是没有什么能阻止渲染器对书籍进行静态分析以验证链接或运行测试.一些现有的渲染器是:

- `html`- 内置渲染器,它将生成该书的 HTML 版本
- [`linkcheck`]- 后端将检查所有链接是否有效
- [`epub`]- 实验性 EPUB 发生器

> **开发人员注意事项:**如果您已经开发了自己的插件并希望在此处提及,请随时向我们发送 PR.

通过安装适当的程序然后在书中提及它来启用预处理器或渲染器`book.toml`文件.

```console
$ cargo install mdbook-linkcheck
$ edit book.toml && cat book.toml
[book]
title = "My Awesome Book"
authors = ["Michael-F-Bryan"]

[output.html]

[output.linkcheck]  # enable the "mdbook-linkcheck" renderer

$ mdbook build
2018-10-20 13:57:51 [INFO] (mdbook::book): Book building has started
2018-10-20 13:57:51 [INFO] (mdbook::book): Running the html backend
2018-10-20 13:57:53 [INFO] (mdbook::book): Running the linkcheck backend
```

有关插件系统的更多信息,请参阅[用户指南].

### 作为一个图书馆

除了命令行界面,此包也可以用作库.这意味着您可以将其集成到现有项目中,例如 Web 应用程序.由于命令行界面只是库功能的包装,因此当您使用此包作为库时,您可以使用易于使用的 API 以及更多来完全访问命令行界面的所有功能!

见[用户指南]和[API 文档]欲获得更多信息.

## 捐款

贡献受到高度赞赏和鼓励!不要犹豫,参与有关问题的讨论,提出新功能并寻求帮助.

如果你刚刚开始使用 Rust,那么有一系列被标记的 issus[E-易]和**我们很乐意指导你**这样您就可以成功完成修复错误或添加新功能的过程!如果您需要任何帮助,请告诉我们.

有关贡献的更多信息,请查看我们的[贡献指南]谁帮助您完成构建和贡献过程!

还有一个[渲染版][master-docs]对于那些黑客攻击的最新 API 文档`master`.

## 执照

此存储库中的所有代码都在下面发布**_Mozilla Public License v2.0_**,有关更多信息,请查看[执照]文件.

[user guide]: https://rust-lang-nursery.github.io/mdBook/
[api docs]: https://docs.rs/mdbook/*/mdbook/
[e-easy]: https://github.com/rust-lang-nursery/mdBook/issues?q=is%3Aopen+is%3Aissue+label%3AE-Easy
[contribution guide]: https://github.com/rust-lang-nursery/mdBook/blob/master/CONTRIBUTING.md
[license]: https://github.com/rust-lang-nursery/mdBook/blob/master/LICENSE
[releases]: https://github.com/rust-lang-nursery/mdBook/releases
[rust]: https://www.rust-lang.org/
[cli docs]: http://rust-lang-nursery.github.io/mdBook/cli/init.html
[master-docs]: http://rust-lang-nursery.github.io/mdBook/mdbook/
[`linkcheck`]: https://crates.io/crates/mdbook-linkcheck
[`epub`]: https://crates.io/crates/mdbook-epub
