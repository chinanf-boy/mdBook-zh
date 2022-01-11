# 致 Developers

虽然`mdbook`主要用作命令行工具, 但您也可以直接导入底层库，并使用它来管理书籍。它还具有相当灵活的插件机制，允许您创建自己的自定义工具和消费者(通常称为*后端*)，如果您需要对书籍进行一些分析，或以不同的格式渲染它.

该 _对于开发人员_ 章节在这里向您展示`mdbook`更高级的用法.

开发人员可以通过以下两种方式，影响本书的构建过程,

- [Preprocessors-预处理器](preprocessors.zh.md)
- [Alternate Backends - 备用后端](backends.zh.md)

## 构建过程

渲染图书项目的过程经历了几个步骤.

1.  加载书
    - 解析`book.toml`。 如果其中不存在，使用`Config`默认值。
    - 将书籍章节加载到内存中
    - 了解应该使用哪些预处理器/后端
2.  对于每个后端：
    1.  运行所有的预处理器
    2.  调用后端，渲染处理过的结果

## `mdbook`作为库使用

`mdbook`二进制只是一个`mdbook`箱的包装器，将其功能暴露出来，作为命令行程序。因此，很容易自制使用`mdbook`的程序，并添加自己的功能(例如自定义预处理器)或调整构建过程。

如何找到使用`mdbook`箱子最简单方法，答案就是[API 文档][api docs]。顶级 API 文档解释了如何使用[`MDBook`]类型，加载和构建一本书，而[config]模块很好地解释了配置系统。

[`mdbook`]: https://docs.rs/mdbook/*/mdbook/book/struct.MDBook.html
[api docs]: https://docs.rs/mdbook/*/mdbook/
[config]: https://docs.rs/mdbook/*/mdbook/config/index.html
