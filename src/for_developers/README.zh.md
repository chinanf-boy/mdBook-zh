# For Developers

而`mdbook`主要用作命令行工具,您也可以直接导入底层库并使用它来管理书籍.它还具有相当灵活的插件机制,允许您创建自己的自定义工具和消费者(通常称为*后端*)如果您需要对书籍进行一些分析或以不同的格式呈现它.

该*对于开发人员*章节在这里向您展示更高级的用法`mdbook`.

开发人员可以通过以下两种方式进入本书的构建过程,

-   [Preprocessors](preprocessors.md)
-   [Alternate Backends](backends.md)

## The Build Process

渲染图书项目的过程经历了几个步骤.

1.  加载书
    -   解析`book.toml`,回到默认值`Config`如果它不存在
    -   将书籍章节加载到内存中
    -   了解应该使用哪些预处理器/后端
2.  运行预处理器
3.  依次呼叫每个后端

## Using `mdbook` as a Library

该`mdbook`二进制只是一个包装器`mdbook`crate,将其功能公开为命令行程序.因此,很容易创建自己的程序使用`mdbook`在内部,添加自己的功能(例如自定义预处理器)或调整构建过程.

找出如何使用的最简单方法`mdbook`箱子是看着[API文档].顶级文档解释了如何使用[`MDBook`]类型加载和构建一本书,而[配置]模块给出了配置系统的一个很好的解释.

[`mdbook`]: http://rust-lang-nursery.github.io/mdBook/mdbook/book/struct.MDBook.html

[api docs]: https://docs.rs/mdbook/*/mdbook/

[config]: file:///home/michael/Documents/forks/mdBook/target/doc/mdbook/config/index.html
