# 备用后端

"后端"只是一个，`mdbook`在书籍渲染过程中调用的程序。该程序通过传递`stdin`的书籍和配置信息的JSON表达式。一旦后端收到这些信息,就可以自由地做任何想做的事情.

GitHub上已有几个备用后端,可以作为在实践中如何实现这一功能的粗略示例.

-   [mdbook-linkcheck]- 用于验证书籍的简单程序，不包含任何损坏的链接
-   [mdbook-EPUB]-  EPUB渲染器
-   [mdbook测试-]- 一个运行书籍内容的程序[防锈怀疑论者-]验证一切编译并正确运行(类似于`rustdoc --test`)

此页面将引导您以简单的单词计数程序的形式创建自己的备用后端.虽然它将用Rust编写,但没有理由不能用Python或Ruby之类的东西来完成它.

## Setting Up

首先,您需要创建一个新的二进制程序并添加`mdbook`作为依赖.

```
$ cargo new --bin mdbook-wordcount
$ cd mdbook-wordcount 
$ cargo add mdbook
```

当我们的`mdbook-wordcount`插件被调用,`mdbook`将发送它的JSON版本[`RenderContext`]通过我们的插件`stdin`.为方便起见,有一个[`RenderContext::from_json()`]将加载的构造函数`RenderContext`.

这是我们后端加载本书所需的所有样板.

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

> **注意:** `RenderContext`包含一个`version`领域.这使得后端可以确定它们是否与版本兼容`mdbook`它被称为.这个`version`直接来自相应的字段`mdbook`的`Cargo.toml`.

建议后端使用[`semver`]如果可能存在兼容性问题,请检查此字段并发出警告.

## Inspecting the Book

现在我们的后端有一本书的副本,让我们计算每章中有多少单词!

因为`RenderContext`包含一个[`Book`]场(`book`),和`Book`有[`Book::iter()`]迭代a中所有项的方法`Book`,这一步变得和第一步一样简单.

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

## Enabling the Backend

现在我们已经运行了基础知识,我们希望实际使用它.首先,安装程序.

```
$ cargo install
```

然后`cd`在特定的书中你想要数字并更新它`book.toml`文件.

```diff
  [book]
  title = "mdBook Documentation"
  description = "Create book from markdown files. Like Gitbook but implemented in Rust"
  authors = ["Mathieu David", "Michael-F-Bryan"]

+ [output.html]

+ [output.wordcount]
```

当它将一本书加载到内存中时`mdbook`会检查你的`book.toml`通过查找所有文件来尝试找出要使用的后端`output.*`表.如果没有提供,它将回退到使用默认的HTML渲染器.

值得注意的是,这意味着如果你想添加自己的自定义后端,你还需要确保添加HTML后端,即使它的表只是空的.

现在你只需要像平常一样构建你的书,一切都应该*干得好*.

```
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
备用后端: 710
Contributors: 85
```

我们之所以不需要指定我们的全名/路径`wordcount`后端是因为`mdbook`会尽力的*推断*程序的名称通过约定.可执行文件`foo`后端通常被称为`mdbook-foo`,与相关联`[output.foo]`进入`book.toml`.明确告诉`mdbook`要调用什么命令(可能需要命令行参数或是解释的脚本),你可以使用`command`领域.

```diff
  [book]
  title = "mdBook Documentation"
  description = "Create book from markdown files. Like Gitbook but implemented in Rust"
  authors = ["Mathieu David", "Michael-F-Bryan"]

  [output.html]

  [output.wordcount]
+ command = "python /path/to/wordcount.py"
```

## Configuration

现在假设您不想计算特定章节上的单词数(可能是生成的文本/代码等).这样做的规范方法是通过常规方式`book.toml`配置文件通过添加项目到您的`[output.foo]`表.

`Config`可以粗略地将其视为嵌套的hashmap,它允许您调用类似的方法`get()`使用a访问配置的内容`get_deserialized()`方便的方法,用于检索值并自动反序列化为某种任意类型`T`.

为实现这一点,我们将创建自己的可序列化`WordcountConfig`struct将封装此后端的所有配置.

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

现在我们只需要反序列化`WordcountConfig`从我们的`RenderContext`然后添加一个检查以确保我们跳过忽略的章节.

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

## Output and Signalling Failure

虽然在构建书籍时将字数计数打印到终端是很好的,但将它们输出到某个文件也可能是个好主意.`mdbook`告诉后端它应该通过哪个放置任何生成的输出`destination`在[`RenderContext`].

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

> **注意:** 无法保证目标目录存在或为空(`mdbook`可能会留下以前的内容让后端进行缓存),因此创建它总是一个好主意`fs::create_dir_all()`.

处理书籍时总会出现错误(只需查看全部内容)`unwrap()`我们已经写过了,所以`mdbook`将非零退出代码解释为渲染失败.

例如,如果我们想确保所有章节都有*甚至*单词的数量,如果遇到奇数,则输出错误,那么你可以这样做:

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

现在,如果我们重新安装后端并构建一本书,

```
$ cargo install --force
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

您可能已经注意到,插件的子进程的输出会立即传递给用户.鼓励插件遵循"静默规则"并且仅在必要时生成输出(例如,生成错误或警告).

所有环境变量都传递到后端,允许您使用通常的`RUST_LOG`控制日志记录详细程度.

## Wrapping Up

虽然做作,但希望这个例子足以说明你如何创建一个备用后端`mdbook`.如果你觉得它遗漏了什么,请不要犹豫,创造一个问题[问题跟踪器]所以我们可以改进用户指南.

在本章开头提到的现有后端应该是它在现实生活中如何完成的一个很好的例子,所以请随意浏览源代码或提出问题.

[mdbook-linkcheck]: https://github.com/Michael-F-Bryan/mdbook-linkcheck

[mdbook-epub]: https://github.com/Michael-F-Bryan/mdbook-epub

[mdbook-test]: https://github.com/Michael-F-Bryan/mdbook-test

[rust-skeptic]: https://github.com/budziq/rust-skeptic

[`rendercontext`]: http://rust-lang-nursery.github.io/mdBook/mdbook/renderer/struct.RenderContext.html

[`rendercontext::from_json()`]: http://rust-lang-nursery.github.io/mdBook/mdbook/renderer/struct.RenderContext.html#method.from_json

[`semver`]: https://crates.io/crates/semver

[`book`]: http://rust-lang-nursery.github.io/mdBook/mdbook/book/struct.Book.html

[`book::iter()`]: http://rust-lang-nursery.github.io/mdBook/mdbook/book/struct.Book.html#method.iter

[`config`]: http://rust-lang-nursery.github.io/mdBook/mdbook/config/struct.Config.html

[issue tracker]: https://github.com/rust-lang-nursery/mdBook/issues
