# Preprocessors

一个*预处理器*只是一些代码，运行在加载书之后,和渲染之前,允许您更新和改变本书。可能的用例是:

- 创建自定义帮助程序`\{{#include /path/to/file.md}}`
- 更新链接`[some chapter](some_chapter.md)`自动更改为`[some chapter](some_chapter.html)`，这是 HTML 渲染器功能
- 用 latex 样式(`$$ \frac{1}{3} $$`)的表达式代替为 mathjax 的等价物

## 勾住 MDBook

MDBook 使用一种相当简单的机制来发现第三方插件。`book.toml`添加了一个新表格(例如`preprocessor.foo`，给`foo`预处理器)，然后`mdbook`将尝试调用`mdbook-foo`程序，作为构建过程的一部分.

虽然预处理器可以进行硬编码,以指定应该运行哪个后端，来处理如`preprocessor.foo.renderer`的字段(但奇奇怪怪的是，像 MathJax 用于非 HTML 渲染器没有意义).

```toml
[book]
title = "My Book"
authors = ["Michael-F-Bryan"]

[preprocessor.foo]
# 指定命令的使用
command = "python3 /path/to/foo.py"
#  `foo` 预处理器 只被用于 HTML 和 EPUB 的渲染器
renderer = ["html", "epub"]
```

在典型的 unix 样式中,插件的所有输入都被写入`stdin`作为 JSON，和`mdbook`将从`stdout`中读取，如果它是期待的输出.

最简单的入门方法是创建自己的实现`Preprocessor` trait(例如在`lib.rs`)，然后创建一个 shell 二进制文件,将输入转换为正确的`Preprocessor`方法。为方便起见,有个[无操作预处理器:示例][an example no-op preprocessor]在`examples/`目录,可以很容易地适应其他预处理器.

<details>
<summary>Example 无操作预处理器</summary>

```rust
// nop-preprocessors.rs

{{#include ../../examples/nop-preprocessor.rs}}
```

</details>

## 实现一个预处理器的提示

通过拉取`mdbook`，作为一个库,预处理器可以访问现有的基础架构来处理书籍.

例如,自定义预处理器可以使用[`CmdPreprocessor::parse_input()`]函数， 用于反序列化写入`stdin`的 JSON。然后是`Book`的每一章可以通过[`Book::for_each_mut()`]成为可变权限，然后随着`serde_json`箱写到`stdout`.

章节可以直接访问(通过递归迭代章节)或通过便利方法`Book::for_each_mut()`.

`chapter.content`只是一个恰好是 markdown 的字符串。虽然完全可以使用正则表达式或进行手动查找和替换，但您可能希望将输入处理为更加计算机友好的内容。该[`pulldown-cmark`][pc]crate 实现了一个基于事件，生产质量的 Markdown 解析器，而[`pulldown-cmark-to-cmark`][pctc]允许您将事件转换回 markdown 文本.

以下代码块，显示了如何从 markdown 中删除所有强调(粗体),而不会意外地破坏文档.

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

对于其他的一切,看[完整的例子][example].

[preprocessor-docs]: https://docs.rs/mdbook/latest/mdbook/preprocess/trait.Preprocessor.html
[pc]: https://crates.io/crates/pulldown-cmark
[pctc]: https://crates.io/crates/pulldown-cmark-to-cmark
[example]: https://github.com/rust-lang-nursery/mdBook/blob/master/examples/nop-preprocessor.rs
[an example no-op preprocessor]: https://github.com/rust-lang-nursery/mdBook/blob/master/examples/nop-preprocessor.rs
[`cmdpreprocessor::parse_input()`]: https://docs.rs/mdbook/latest/mdbook/preprocess/trait.Preprocessor.html#method.parse_input
[`book::for_each_mut()`]: https://docs.rs/mdbook/latest/mdbook/book/struct.Book.html#method.for_each_mut
