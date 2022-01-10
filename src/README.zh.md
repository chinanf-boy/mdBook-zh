# 介绍

**mdBook** 是一个命令行工具，可以将 Markdown 文档，变成 HTML 网站。
这样的工具，用在产品信息或是 API 文档, 教程, 课件资料等等场景。

- **轻量级：** [Markdown] 语法
- **搜索：** 集成 [search] 功能
- **语法高亮：** [syntax highlighting] 
- **多个主题：** [Theme] 自定义输出的格式
- **预先处理器：** [Preprocessors] 预处理的扩展，比如
- **后端：** [Backends] 选择输出的渲染格式
- 自然，还具有 [Rust] 加持，速度杠杠的。
- 甚至，[Rust 代码][Rust code samples] 的自动测试。 

本指南，带你进入，快进快出的现代化文档工具。
mdBook 是 Rust 官方的项目, 还有 [The Rust Programming Language][trpl] 也是使用 **本工具** 的

[markdown]: format/markdown.zh.md
[search]: guide/reading.zh.md#search
[syntax highlighting]: format/theme/syntax-highlighting.zh.md
[theme]: format/theme/index.html
[preprocessors]: format/configuration/preprocessors.zh.md
[backends]: format/configuration/renderers.zh.md
[rust]: https://www.rust-lang.org/
[trpl]: https://doc.rust-lang.org/book/
[rust code samples]: cli/test.zh.md

## Contributing

> 译者：这就不翻译了，有心者事竟成。

mdBook is free and open source. You can find the source code on
[GitHub](https://github.com/rust-lang/mdBook) and issues and feature requests can be posted on
the [GitHub issue tracker](https://github.com/rust-lang/mdBook/issues). mdBook relies on the community to fix bugs and
add features: if you'd like to contribute, please read
the [CONTRIBUTING](https://github.com/rust-lang/mdBook/blob/master/CONTRIBUTING.md) guide and consider opening
a [pull request](https://github.com/rust-lang/mdBook/pulls).

## License

mdBook,所有源代码,都是在[Mozilla Public License
v2.0](https://www.mozilla.org/MPL/2.0/)下发布的.
