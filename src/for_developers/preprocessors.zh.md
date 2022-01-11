# Preprocessors

一个 _预处理器_ 只是一些代码，运行在加载书之后，和渲染之前，允许您更新和改变本书。可能的用例是:

- 创建自定义帮助程序`\{{#include /path/to/file.md}}`
- 用 latex 样式(`$$ \frac{1}{3} $$`)的表达式代替为 mathjax 的等价物

[配置 预处理器](../format/configuration/preprocessors.zh.md) 获取更多信息。

## 勾住 MDBook

MDBook 使用一种相当简单的机制来发现第三方插件。`book.toml`添加了一个新表格(例如`preprocessor.foo`，给`foo`预处理器)，然后`mdbook`将尝试调用`mdbook-foo`程序，作为构建过程的一部分.

一旦预处理器定义了，和构建过程开始，mdBook 会执行`preprocessor.foo.command`命令两次。
第一次是，预处理器检测出是否支持所给予的渲染器。
mdBook 会传递两个参数: 第一个是 `supports` 和第二个参数是渲染器的名字。
支持的话，状态就是 0；不然退出代码为非零。

如果支持， 那么 mdbook 开启命令的第二次运行， 将 JSON 数据传递到 stdin。
The JSON 的组成是一个 `[context, book]` 数组 ( `context` 是序列化对象 [`PreprocessorContext`]) 和 `book` (是一个[`Book`] 包含书的内容)。

预处理器应该返回 [`Book`] 对象的 JSON 格式到 stdout，带有它对内容的修改。

最简单的入门方法是创建自己的实现`Preprocessor` trait(例如在`lib.rs`)，然后创建一个 shell 二进制文件，将输入转换为正确的`Preprocessor`方法。为方便起见，有个[无操作预处理器:示例][an example no-op preprocessor]在`examples/`目录，可以很容易地适应其他预处理器.

<details>
<summary>Example 无操作预处理器</summary>

```rust
// nop-preprocessors.rs

{{#include ../../examples/nop-preprocessor.rs}}
```

</details>

## 实现一个预处理器的提示

通过拉取`mdbook`，作为一个库，预处理器可以访问现有的基础架构来处理书籍.

例如，自定义预处理器可以使用[`CmdPreprocessor::parse_input()`]函数， 用于反序列化写入`stdin`的 JSON。然后是`Book`的每一章可以通过[`Book::for_each_mut()`]成为可变权限，然后随着`serde_json`箱写到`stdout`.

章节可以直接访问(通过递归迭代章节)或通过便利方法`Book::for_each_mut()`.

`chapter.content`只是一个恰好是 markdown 的字符串。虽然完全可以使用正则表达式或进行手动查找和替换，但您可能希望将输入处理为更加计算机友好的内容。该[`pulldown-cmark`][pc]crate 实现了一个基于事件，生产质量的 Markdown 解析器，而[`pulldown-cmark-to-cmark`][pctc]允许您将事件转换回 markdown 文本.

以下代码块，显示了如何从 markdown 中删除所有强调(粗体)，而不会意外地破坏文档.

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

对于其他的一切，看[完整的例子][example].

## Implementing a preprocessor with a different language

stdin 与 stdout 是预处理器的交流频道，这种方式让其他语言也能参与进来。比如 Python，下面是修改第一章内容的示例：
`preprocessor.foo.command` 指向的实际命令。

```python
import json
import sys


if __name__ == '__main__':
    if len(sys.argv) > 1: # we check if we received any argument
        if sys.argv[1] == "supports":
            # then we are good to return an exit status code of 0, since the other argument will just be the renderer's name
            sys.exit(0)

    # load both the context and the book representations from stdin
    context, book = json.load(sys.stdin)
    # and now, we can just modify the content of the first chapter
    book['sections'][0]['Chapter']['content'] = '# Hello'
    # we are done with the book's modification, we can just print it to stdout,
    print(json.dumps(book))
```

[preprocessor-docs]: https://docs.rs/mdbook/latest/mdbook/preprocess/trait.Preprocessor.html
[pc]: https://crates.io/crates/pulldown-cmark
[pctc]: https://crates.io/crates/pulldown-cmark-to-cmark
[example]: https://github.com/rust-lang/mdBook/blob/master/examples/nop-preprocessor.rs
[an example no-op preprocessor]: https://github.com/rust-lang/mdBook/blob/master/examples/nop-preprocessor.rs
[`cmdpreprocessor::parse_input()`]: https://docs.rs/mdbook/latest/mdbook/preprocess/trait.Preprocessor.html#method.parse_input
[`book::for_each_mut()`]: https://docs.rs/mdbook/latest/mdbook/book/struct.Book.html#method.for_each_mut
[`preprocessorcontext`]: https://docs.rs/mdbook/latest/mdbook/preprocess/struct.PreprocessorContext.html
[`book`]: https://docs.rs/mdbook/latest/mdbook/book/struct.Book.html
