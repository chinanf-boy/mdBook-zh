# 备用后端

"后端"只是一个，`mdbook`在书籍渲染过程中调用的程序。该程序会拿到传递到`stdin`的书籍和配置信息的 JSON 表达式。一旦后端收到这些信息,就可以自由地做任何想做的事情.

[Configuring Renderers](../format/configuration/renderers.zh.md) 有更多信息。

社区也开发了几个后端 [Third Party Plugins]

## 目录

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [设置好](#%E8%AE%BE%E7%BD%AE%E5%A5%BD)
- [检查 Book](#%E6%A3%80%E6%9F%A5-book)
- [启用吧，我的 Backend](#%E5%90%AF%E7%94%A8%E5%90%A7%E6%88%91%E7%9A%84-backend)
- [配置](#%E9%85%8D%E7%BD%AE)
- [输出和信号故障](#%E8%BE%93%E5%87%BA%E5%92%8C%E4%BF%A1%E5%8F%B7%E6%95%85%E9%9A%9C)
- [包涵包涵](#%E5%8C%85%E6%B6%B5%E5%8C%85%E6%B6%B5)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 设置好

此页面将引导您，创建自己的单词计数程序的简单形式的备用后端。虽然它将用 Rust 编写，但没有理由不能用 Python 或 Ruby 之类，来完成它。

首先，您需要创建一个新的二进制程序，并添加`mdbook`作为依赖.

```shell
$ cargo new --bin mdbook-wordcount
$ cd mdbook-wordcount
$ cargo add mdbook
```

捋一捋，当我们的`mdbook-wordcount`插件被调用，`mdbook`将通过我们的插件的`stdin`，发送它[`RenderContext`]的 JSON 版本。为方便起见，有一个[`RenderContext::from_json()`]构造函数，加载一个`RenderContext`。

这是我们后端加载本书，所需的所有样板.

```rust
// src/main.rs
extern crate mdbook;

use std::io;
use mdbook::renderer::RenderContext;

fn main() {
    let mut stdin = io::stdin();
    let ctx = RenderContext::from_json(&mut stdin).unwrap();
}
```

> **注意:** `RenderContext`包含一个`version`字段。这使得后端在被调用时确定它们是否与`mdbook`版本兼容。这个`version`直接来自`mdbook`的`Cargo.toml`中的相应字段.

建议后端使用[`semver`]，如果可能存在兼容性问题,请检查此字段，并发出警告.

## 检查 Book

现在我们的后端有一本书的副本,让我们计算每章中有多少单词!

因为`RenderContext`包含一个[`Book`]字段(`book`),和一个`Book`有[`Book::iter()`]，用于迭代其`Book`中所有项的方法，这一步就和第一步一样简单.

```rust
fn main() {
    let mut stdin = io::stdin();
    let ctx = RenderContext::from_json(&mut stdin).unwrap();

    for item in ctx.book.iter() {
        if let BookItem::Chapter(ref ch) = *item {
            let num_words = count_words(ch);
            println!("{}: {}", ch.name, num_words);
        }
    }
}

fn count_words(ch: &Chapter) -> usize {
    ch.content.split_whitespace().count()
}
```

## 启用吧，我的 Backend

现在我们的基本部分已经运行了，我们希望实际使用它。那首先,当然是安装程序.

```
$ cargo install --path .
```

然后`cd`在特定的书目录中，若你想要数字计数，那更新它的`book.toml`文件.

```diff
  [book]
  title = "mdBook Documentation"
  description = "Create book from markdown files. Like Gitbook but implemented in Rust"
  authors = ["Mathieu David", "Michael-F-Bryan"]

+ [output.html]

+ [output.wordcount]
```

当`mdbook`将一本书加载到内存中时，它会尝试检查你的`book.toml`，并查找所有`output.*`表格来尝试找出要使用的后端。如果没有提供，它将回退到，使用默认的 HTML 渲染器.

值得注意的是，这表示如果你想添加自己的自定义后端，你还需要确保添加 HTML 后端，即使只是空表格。

现在你只需要像平常一样构建你的书，一切都应该 *可以工作*。

```shell
$ mdbook build
...
2018-01-16 07:31:15 [INFO] (mdbook::renderer): Invoking the "mdbook-wordcount" renderer
mdBook: 126
Command Line Tool: 224
init: 283
build: 145
watch: 146
serve: 292
test: 139
Format: 30
SUMMARY.md: 259
Configuration: 784
Theme: 304
index.hbs: 447
Syntax highlighting: 314
MathJax Support: 153
Rust code specific features: 148
For Developers: 788
Alternative Backends: 710
Contributors: 85
```

我们之所以不需要指定我们`wordcount`后端的全名/路径，是因为`mdbook`会尽力的*推断*程序的名称，这些都是因为规范化，如下: 可执行文件`foo`后端通常被称为`mdbook-foo`，还有相关联的`[output.foo]`会进入`book.toml`。而要明确告诉`mdbook`要调用什么命令(可能需要命令行参数或是解释的脚本)， 你可以使用`command`字段。

```diff
  [book]
  title = "mdBook Documentation"
  description = "Create book from markdown files. Like Gitbook but implemented in Rust"
  authors = ["Mathieu David", "Michael-F-Bryan"]

  [output.html]

  [output.wordcount]
+ command = "python /path/to/wordcount.py"
```

## 配置

现在假设您不想计算特定章节上的单词数(可能是生成的文本/代码等)。要做到这样的规范方法，是通过常规`book.toml`配置文件，添加个别项到您的`[output.foo]`表格。

`Config`可以粗略地视为嵌套的`hashmap`，它允许您调用类似的方法`get()`使用访问配置的内容，也带`get_deserialized()`这一方便方法,用于检索值，并自动反序列化为某种任意类型`T`.

为实现这一点,我们将创建自己的可序列化`WordcountConfig`结构将封装此后端的所有配置.

首先添加`serde`和`serde_derive`到你的`Cargo.toml`,

```
$ cargo add serde serde_derive
```

然后你可以创建配置结构,

```rust
extern crate serde;
#[macro_use]
extern crate serde_derive;

...

#[derive(Debug, Default, Serialize, Deserialize)]
#[serde(default, rename_all = "kebab-case")]
pub struct WordcountConfig {
  pub ignores: Vec<String>,
}
```

现在我们只需要我们的`RenderContext`，反序列化成`WordcountConfig`，然后添加一个检查，以确保我们跳过忽略的章节。

```diff
  fn main() {
      let mut stdin = io::stdin();
      let ctx = RenderContext::from_json(&mut stdin).unwrap();
+     let cfg: WordcountConfig = ctx.config
+         .get_deserialized("output.wordcount")
+         .unwrap_or_default();

      for item in ctx.book.iter() {
          if let BookItem::Chapter(ref ch) = *item {
+             if cfg.ignores.contains(&ch.name) {
+                 continue;
+             }
+
              let num_words = count_words(ch);
              println!("{}: {}", ch.name, num_words);
          }
      }
  }
```

## 输出和信号故障

虽然在构建书籍时，将字数计数打印到终端是很好的，但将它们输出到某个文件也可能是个好主意。`mdbook`能告诉后端，它应该根据[`RenderContext`]的`destination`字段，放置输出的位置，.

```diff
+ use std::fs::{self, File};
+ use std::io::{self, Write};
- use std::io;
  use mdbook::renderer::RenderContext;
  use mdbook::book::{BookItem, Chapter};

  fn main() {
    ...

+     let _ = fs::create_dir_all(&ctx.destination);
+     let mut f = File::create(ctx.destination.join("wordcounts.txt")).unwrap();
+
      for item in ctx.book.iter() {
          if let BookItem::Chapter(ref ch) = *item {
              ...

              let num_words = count_words(ch);
              println!("{}: {}", ch.name, num_words);
+             writeln!(f, "{}: {}", ch.name, num_words).unwrap();
          }
      }
  }
```

> **注意:** 无法保证目标目录存在或为空(`mdbook`可能会留下以前的内容让后端进行缓存)，因此创建它`fs::create_dir_all()`总不会错。
>
> 如果目的地目录已存在, 不要假设它就一定是空的。
> 要知道，后端是有上一结果缓存的, `mdbook` 或许会留下
> 旧的内容在里面。

处理书籍时，总会出现错误(只需查看全部我们已经写过了的`unwrap()`)吗，所以`mdbook`会渲染失败后，非零退出代码。

例如，如果我们想确保所有章节的单词，都有*偶数*数量， 而如果遇到奇数，则输出错误，那么你可以这样做:

```diff
+ use std::process;
  ...

  fn main() {
      ...

      for item in ctx.book.iter() {
          if let BookItem::Chapter(ref ch) = *item {
              ...

              let num_words = count_words(ch);
              println!("{}: {}", ch.name, num_words);
              writeln!(f, "{}: {}", ch.name, num_words).unwrap();

+             if cfg.deny_odds && num_words % 2 == 1 {
+               eprintln!("{} has an odd number of words!", ch.name);
+               process::exit(1);
              }
          }
      }
  }

  #[derive(Debug, Default, Serialize, Deserialize)]
  #[serde(default, rename_all = "kebab-case")]
  pub struct WordcountConfig {
      pub ignores: Vec<String>,
+     pub deny_odds: bool,
  }
```

现在，如果我们重新安装后端，并构建一本书,

```shell
$ cargo install --path . --force
$ mdbook build /path/to/book
...
2018-01-16 21:21:39 [INFO] (mdbook::renderer): Invoking the "wordcount" renderer
mdBook: 126
Command Line Tool: 224
init: 283
init has an odd number of words!
2018-01-16 21:21:39 [ERROR] (mdbook::renderer): Renderer exited with non-zero return code.
2018-01-16 21:21:39 [ERROR] (mdbook::utils): Error: Rendering failed
2018-01-16 21:21:39 [ERROR] (mdbook::utils):    Caused By: The "mdbook-wordcount" renderer failed
```

您可能已经注意到，插件的子进程的输出会立即传递给用户。鼓励插件遵循"安静规则"，且仅在必要时生成输出(例如，生成错误或警告)。

所有环境变量都传递到后端，允许您使用常用的`RUST_LOG`，控制日志记录详细程度.

## 包涵包涵

虽然有点做作，但希望这个例子足以说明，如何创建一个`mdbook`备用后端。如果你觉得它遗漏了什么，请不要犹豫，创造一个问题的[issue tracker]，让我们可以一起改进用户指南。

在本章开头提到的现有后端，应该是现实生活中如何完成后端的很好例子，所以请随意浏览源代码，或提出问题.

[mdbook-linkcheck]: https://github.com/Michael-F-Bryan/mdbook-linkcheck
[mdbook-epub]: https://github.com/Michael-F-Bryan/mdbook-epub
[mdbook-test]: https://github.com/Michael-F-Bryan/mdbook-test
[rust-skeptic]: https://github.com/budziq/rust-skeptic
[`rendercontext`]: https://docs.rs/mdbook/*/mdbook/renderer/struct.RenderContext.html
[`rendercontext::from_json()`]: https://docs.rs/mdbook/*/mdbook/renderer/struct.RenderContext.html#method.from_json
[`semver`]: https://crates.io/crates/semver
[`book`]: https://docs.rs/mdbook/*/mdbook/book/struct.Book.html
[`book::iter()`]: https://docs.rs/mdbook/*/mdbook/book/struct.Book.html#method.iter
[`config`]: https://docs.rs/mdbook/*/mdbook/config/struct.Config.html
[issue tracker]: https://github.com/rust-lang/mdBook/issues
