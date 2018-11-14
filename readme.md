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

- [x] readme
- [x] [SUMMARY.md](./src/SUMMARY.md)
- [x] [mdbook](./src/README.zh.md)
- [x] [命令行工具](./src/cli/README.zh.md)
  - [x] [init](./src/cli/init.zh.md)
  - [x] [build](./src/cli/build.zh.md)
  - [x] [watch](./src/cli/watch.zh.md)
  - [x] [serve](./src/cli/serve.zh.md)
  - [x] [test](./src/cli/test.zh.md)
  - [x] [clean](./src/cli/clean.zh.md)
- [x] [格式](./src/format/README.zh.md)
  - [x] [SUMMARY.md](./src/format/summary.zh.md)
  - [x] [配置](./src/format/config.zh.md)
  - [x] [Theme-主题](./src/format/theme/README.zh.md)
    - [x] [index.hbs](./src/format/theme/index-hbs.zh.md)
    - [x] [语法高亮显示](./src/format/theme/syntax-highlighting.zh.md)
    - [x] [编辑器](./src/format/theme/editor.zh.md)
  - [x] [MathJax 支持](./src/format/mathjax.zh.md)
  - [x] [mdBook 特殊功能](./src/format/mdbook.zh.md)
- [x] [持续集成](./src/continuous-integration.zh.md)
- [x] [对开发者说](./src/for_developers/README.zh.md)
  - [x] [预处理程序](./src/for_developers/preprocessors.zh.md)
  - [ ] [备用后端](./src/for_developers/backends.zh.md)

---

- [x] [贡献者](./src/misc/contributors.zh.md)

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

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [它是什么样子的?](#%E5%AE%83%E6%98%AF%E4%BB%80%E4%B9%88%E6%A0%B7%E5%AD%90%E7%9A%84)
- [安装](#%E5%AE%89%E8%A3%85)
- [用法](#%E7%94%A8%E6%B3%95)
  - [第三方插件](#%E7%AC%AC%E4%B8%89%E6%96%B9%E6%8F%92%E4%BB%B6)
  - [作为一个 crate 库](#%E4%BD%9C%E4%B8%BA%E4%B8%80%E4%B8%AAcrate%E5%BA%93)
- [捐款](#%E6%8D%90%E6%AC%BE)
- [执照](#%E6%89%A7%E7%85%A7)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 它是什么样子的?

该[user guide]对于 mdBook 已经用 Markdown 编写,并且正在使用 mdBook 生成您可以阅读的在线书籍式网站.该文档使用 GitHub 上的最新版本并展示了可用的功能.

## 安装

有多种方法可以安装 mdBook.

1.  **二进制**

    二进制文件可供下载[这里][releases].确保将二进制文件的路径放入您的`PATH`.

2.  **来自 Crates.io**

    这至少需要[rust]1.20 和 Cargo 安装.安装 Rust 后,在终端中键入以下内容:

    ```
    cargo install mdbook
    ```

    这将为您下载并编译 mdBook,剩下要做的就是将 Cargo bin 目录添加到您的`PATH`.

    **注意自动部署**

    如果您使用脚本使用 Travis 或其他 CI 服务器进行自动部署,我们建议您在通过脚本安装 mdBook 时,为 mdBook 指定 semver 版本范围!

    这将限制服务器安装最新版本**非破坏**mdBook 的版本,因为我们发布了新版本, 却阻止了您书构建.例如:

    ```
    cargo install mdbook --vers "^0.1.0"
    ```

3.  **来自 Git**

    发布到 crates.io 的版本将略微落后于 GitHub 上托管的版本。如果您需要最新版本,可以自己构建 mdBook 的 git 版本。Cargo 就是这样**_超级容易_**!

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

    生成的二进制文件可以在`mdBook/target/debug/`中找到，`mdBook`或`mdBook.exe`名.

## 用法

mdBook 将主要用作命令行工具,即使它将其所有功能公开为 Rust crate， 以便在其他项目中集成.

以下是您要运行的主要命令.有关更详尽的解释,请查看[user guide].

- `mdbook init`

  init 命令将创建一个目录,其中包含最小的样板文件.

  ```
  book-test/
  ├── book
  └── src
      ├── chapter_1.md
      └── SUMMARY.md
  ```

  `book`和`src`都是目录.`src`包含 markdown 文件, `book`目录输出渲染的目录.

  请看看[CLI docs]了解更多信息和一些巧妙的技巧.

- `mdbook build`

  这是您将用于渲染书的命令,​​ 它会读取`SUMMARY.md`了解书结构的文件,将源目录中的 markdown 文件作为输入,并输出可以上传到服务器的静态 html 页面.

- `mdbook watch`

  运行此命令时,mdbook 将监视您的 markdown 文件,以便在每次更改时重建本书.这避免了必须返回终端，一遍又一遍地进行`mdbook build`.

- `mdbook serve`

  做`mdbook watch`同样的事情但，另外还提供了这本书`http://localhost:3000`(端口可更改)，并在发生更改时重新加载浏览器.

- `mdbook clean`

  删除生成的书籍所在的目录.

### 第三方插件

用户可以通过第三方插件配置书籍的加载和渲染方式。这些插件只是在构建过程中调用的程序,大致分为两类,*预处理器*和*渲染器*.

预处理器用于在将书籍发送到渲染器之前，对其进行转换。一个例子是所有出现的`{{#include some_file.ext}}`都被替换成该文件的内容。一些现有的预处理器是:

- `index`- 一个内置的预处理器(默认启用),它将转换所有`README.md`章节到`index.md`，所以`foo/README.md`可以通过`foo/`网址访问,省略了`index.html`。
- `links`- 内置预处理器(默认启用),用于扩展`{{# playpen}}`和`{{# include}}`帮手.

渲染器将 ​​ 获得最终的书籍,以便他们可以使用它。顾名思义,这通常用于以特定格式渲染文档，但是没有什么能阻止渲染器对书籍进行静态分析，以验证链接或运行测试。一些现有的渲染器是:

- `html`- 内置渲染器,它将生成该书的 HTML 版本
- [`linkcheck`]- 后端将检查所有链接是否有效
- [`epub`]- 实验性 EPUB 生成

> **开发人员注意事项:** 如果您已经开发了自己的插件，并希望在此处提及,请随时向我们发送 PR.

通过安装适当的程序，然后在书的`book.toml`文件中提及它，来启用预处理器或渲染器.

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

有关插件系统的更多信息,请参阅[user guide].

### 作为一个 crate 库

除了命令行界面,此包也可以用作库。这意味着您可以将其集成到现有项目中,例如 Web 应用程序.由于命令行界面只是库功能的包装,因此当您使用此包作为库时,您可以使用易于使用的 API ，以及更多来完全访问命令行界面的所有功能!

见[user guide]和[API docs]欲获得更多信息.

## 捐款

贡献受到高度赞赏和鼓励! 不要犹豫,参与有关问题的讨论,提出新功能并寻求帮助.

如果你刚刚开始使用 Rust,那么有一系列被标记为[E-easy]和**我们很乐意指导你**的 issus，这样您就可以成功完成修复错误或添加新功能的过程! 如果您需要任何帮助,请告诉我们.

有关贡献的更多信息,请查看我们的[contribution guide],帮助您完成构建和贡献过程!

还有一个[网页版][master-docs]，对于那些想 hacking 最新`master` API 文档.

## 执照

此存储库中的所有代码都在下面发布**_Mozilla Public License v2.0_**,有关更多信息,请查看[license]文件.

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
