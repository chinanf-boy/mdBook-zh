# rust-lang/mdBook [![translate-svg]][translate-list]

<!-- [![explain]][source] -->

[explain]: http://llever.com/explain.svg
[source]: https://github.com/chinanf-boy/Source-Explain
[translate-svg]: http://llever.com/translate.svg
[translate-list]: https://github.com/chinanf-boy/chinese-translate-list

「 一个从 Markdown 文件，创建现代在线书籍的实用程序 」

[中文](./readme.md) | [english](https://github.com/rust-lang/mdBook)

---

## 更新 √ 

<!-- doc-templite START generated -->
<!-- repo = 'rust-lang/mdBook' -->
<!-- commit = '64838ce07df787761bba5451fb23428c9ff66b77' -->
<!-- time = '2022-01-08' -->

| 翻译的原文 | 与日期        | 最新更新 | 更多                       |
| ---------- | ------------- | -------- | -------------------------- |
| [commit]   | ⏰ 2022-01-08 | ![last]  | [中文翻译][translate-list] |

[last]: https://img.shields.io/github/last-commit/rust-lang/mdBook.svg
[commit]: https://github.com/rust-lang/mdBook/tree/64838ce07df787761bba5451fb23428c9ff66b77

<!-- doc-templite END generated -->

<details>

- readme
# Summary

[Introduction](src/README.zh.md)

# User Guide

- [Installation](src/guide/installation.zh.md)
- [Reading Books](src/guide/reading.zh.md)
- [Creating a Book](src/guide/creating.zh.md)

# Reference Guide

- [Command Line Tool](src/cli/README.zh.md)
  - [init](src/cli/init.zh.md)
  - [build](src/cli/build.zh.md)
  - [watch](src/cli/watch.zh.md)
  - [serve](src/cli/serve.zh.md)
  - [test](src/cli/test.zh.md)
  - [clean](src/cli/clean.zh.md)
  - [completions](src/cli/completions.zh.md)
- [Format](src/format/README.zh.md)
  - [SUMMARY.md](src/format/summary.zh.md)
    - [Draft chapter](src/)
  - [Configuration](src/format/configuration/README.zh.md)
    - [General](src/format/configuration/general.zh.md)
    - [Preprocessors](src/format/configuration/preprocessors.zh.md)
    - [Renderers](src/format/configuration/renderers.zh.md)
    - [Environment Variables](src/format/configuration/environment-variables.zh.md)
  - [Theme](src/format/theme/README.zh.md)
    - [index.hbs](src/format/theme/index-hbs.zh.md)
    - [Syntax highlighting](src/format/theme/syntax-highlighting.zh.md)
    - [Editor](src/format/theme/editor.zh.md)
  - [MathJax Support](src/format/mathjax.zh.md)
  - [mdBook-specific features](src/format/mdbook.zh.md)
  - [Markdown](src/format/markdown.zh.md)
- [Continuous Integration](src/continuous-integration.zh.md)
- [For Developers](src/for_developers/README.zh.md)
  - [Preprocessors](src/for_developers/preprocessors.zh.md)
  - [Alternative Backends](src/for_developers/backends.zh.md)
  
</details>

### 贡献

欢迎 👏 勘误/校对/更新贡献 😊 [具体贡献请看](https://github.com/chinanf-boy/chinese-translate-list#贡献)

## 生活

[If help, **buy** me coffee —— 营养跟不上了，给我来瓶营养快线吧! 💰](https://github.com/chinanf-boy/live-need-money)

---

# mdBook

[![Build Status](https://github.com/rust-lang/mdBook/workflows/CI/badge.svg?event=push)](https://github.com/rust-lang/mdBook/actions?workflow=CI)
[![crates.io](https://img.shields.io/crates/v/mdbook.svg)](https://crates.io/crates/mdbook)
[![LICENSE](https://img.shields.io/github/license/rust-lang/mdBook.svg)](LICENSE)

mdBook 是一个把 Markdown 文件，创建为现代在线图书的实用程序。

查看 **[用户指南][user guide]** 有关功能，以及安装和使用信息的列表。《用户指南》还可以作为展示书籍外观的演示。

如果您对 mdBook 的开发感兴趣，请查看 [Contribution Guide]。

## License

此存储库中的所有代码都是在 **_Mozilla 公共许可证 v2。0_** ，有关更多信息，请参阅[LICENSE]文件

[user guide]: https://llever.com/mdBook-zh
[contribution guide]: https://github.com/rust-lang/mdBook/blob/master/CONTRIBUTING.md
[license]: https://github.com/rust-lang/mdBook/blob/master/LICENSE
