# Preprocessors

一个*预处理器*只是一些代码在加载书之后和呈现之前立即运行,允许您更新和改变本书.可能的用例是:

-   创建自定义帮助程序`\{{#include /path/to/file.md}}`
-   更新链接`[some chapter](some_chapter.md)`自动更改为`[some chapter](some_chapter.html)`对于HTML渲染器
-   用乳胶式表达代替(`$$ \frac{1}{3} $$`)与他们的mathjax等价物

## Hooking Into MDBook

MDBook使用一种相当简单的机制来发现第三方插件.添加了一个新表`book.toml`(例如.`preprocessor.foo`为了`foo`预处理器)然后`mdbook`将尝试调用`mdbook-foo`程序作为构建过程的一部分.

虽然预处理器可以进行硬编码,以指定应该运行哪个后端(例如,将MathJax用于非HTML渲染器没有意义)`preprocessor.foo.renderer`键.

```toml
[book]
title = "My Book"
authors = ["Michael-F-Bryan"]

[preprocessor.foo]
# The command can also be specified manually
command = "python3 /path/to/foo.py"
# Only run the `foo` preprocessor for the HTML and EPUB renderer
renderer = ["html", "epub"]
```

在典型的unix样式中,插件的所有输入都将被写入`stdin`作为JSON和`mdbook`将从中读取`stdout`如果它是期待输出.

最简单的入门方法是创建自己的实现`Preprocessor`特质(例如在...中`lib.rs`)然后创建一个shell二进制文件,将输入转换为正确的`Preprocessor`方法.为方便起见,有[示例无操作预处理器-]在里面`examples/`目录,可以很容易地适应其他预处理器.

<details>
<summary>Example no-op preprocessor</summary>

```rust
// nop-preprocessors.rs

{{#include ../../../examples/nop-preprocessor.rs}}
```

</details>

## Hints For Implementing A Preprocessor

通过拉入`mdbook`作为一个库,预处理器可以访问现有的基础架构来处理书籍.

例如,自定义预处理器可以使用[`CmdPreprocessor::parse_input()`]用于反序列化写入的JSON的函数`stdin`.然后是每一章`Book`可以通过就地变异[`Book::for_each_mut()`],然后写到`stdout`随着`serde_json`箱.

章节可以直接访问(通过递归迭代章节)或通过`Book::for_each_mut()`便利方法.

`chapter.content`只是一个恰好是markdown的字符串.虽然完全可以使用正则表达式或进行手动查找和替换,但您可能希望将输入处理为更加计算机友好的内容.该[`pulldown-cmark`][pc]crate实现了一个基于生产质量事件的Markdown解析器[`pulldown-cmark-to-cmark`][pctc]允许您将事件转换回markdown文本.

以下代码块显示了如何从markdown中删除所有强调,而不会意外地破坏文档.

```rust
fn remove_emphasis(
    num_removed_items: &mut usize,
    chapter: &mut Chapter,
) -> Result<String> {
    let mut buf = String::with_capacity(chapter.content.len());

    let events = Parser::new(&chapter.content).filter(|e| {
        let should_keep = match *e {
            Event::Start(Tag::Emphasis)
            | Event::Start(Tag::Strong)
            | Event::End(Tag::Emphasis)
            | Event::End(Tag::Strong) => false,
            _ => true,
        };
        if !should_keep {
            *num_removed_items += 1;
        }
        should_keep
    });

    cmark(events, &mut buf, None).map(|_| buf).map_err(|err| {
        Error::from(format!("Markdown serialization failed: {}", err))
    })
}
```

对于其他一切,看看[在完整的例子][example].

[preprocessor-docs]: https://docs.rs/mdbook/latest/mdbook/preprocess/trait.Preprocessor.html

[pc]: https://crates.io/crates/pulldown-cmark

[pctc]: https://crates.io/crates/pulldown-cmark-to-cmark

[example]: https://github.com/rust-lang-nursery/mdBook/blob/master/examples/de-emphasize.rs

[an example no-op preprocessor]: https://github.com/rust-lang-nursery/mdBook/blob/master/examples/nop-preprocessor.rs

[`cmdpreprocessor::parse_input()`]: https://docs.rs/mdbook/latest/mdbook/preprocess/trait.Preprocessor.html#method.parse_input

[`book::for_each_mut()`]: https://docs.rs/mdbook/latest/mdbook/book/struct.Book.html#method.for_each_mut
