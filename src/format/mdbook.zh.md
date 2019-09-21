# mdBook 特有 markdown

## 隐藏代码行数

mdBook 中有一个功能,可以通过在代码行前加上`#`来隐藏代码行.

```bash
# fn main() {
    let x = 5;
    let y = 6;

    println!("{}", x + y);
# }
```

渲染为

```rust
# fn main() {
    let x = 5;
    let y = 7;

    println!("{}", x + y);
# }
```

## include，包含文件内容

使用以下语法,您可以将文件包含到您的书中:

```hbs
\{{#include file.rs}}
```

文件的路径必须是 **当前** 源文件的 **相对** 路径.

通常,此命令用于包含代码段和示例。在这种情况下, 可指定文件的包含部分,例如其中只包含示例的相关行.

mdBook 会将 include 文件 解释成 markdown。 自从 include 命令常用来插入代码片段和示例，你会习惯使用 ` ``` ` 包裹这些命令，显示（include）文件的内容，而不是去解释它们。

````hbs
```
\{{#include file.rs}}
```
````

## 只 Include 一个文件的部分内容

常见要求是你只要文件的部分内容 e.g. 以行编号作为例子。我们对部分内容插入，支持了几种模式:

```hbs
\{{#include file.rs:2}}
\{{#include file.rs::10}}
\{{#include file.rs:2:}}
\{{#include file.rs:2:10}}
```

我们支持四种不同的决定`file.rs`部分模式:

- 第一个命令仅包含文件中的第二行.
- 第二个命令包含直到第 10 行的所有行。即,从 11 到文件末尾的行被省略.
- 第三个命令包含第 2 行的所有行,即省略第一行.
- 最后一个命令包含摘录`file.rs`由 2 到 10 行组成.

为了防止文件的修改（行数的变化），导致图书呈现内容的变化, 你还可以使用锚点(anchor)，选择一个特定的部分，
行数就不再相关。
一个 anchor 是一对匹配的行。 匹配的内容正是正则式，如开头的行anchor必须匹配"ANCHOR:\s*[\w_-]+" and similarly 结尾行则是 "ANCHOR_END:\s*[\w_-]+"。只要内容匹配了，注释的写法格式倒是没有限制。

考虑下面 要 include 的文件:

```rs
/* ANCHOR: all */

// ANCHOR: component
struct Paddle {
    hello: f32,
}
// ANCHOR_END: component

////////// ANCHOR: system
impl System for MySystem { ... }
////////// ANCHOR_END: system

/* ANCHOR_END: all */
```

给个示例，你要做的:

````hbs
Here is a component:
```rust,no_run,noplaypen
\{{#include file.rs:component}}
```

Here is a system:
```rust,no_run,noplaypen
\{{#include file.rs:system}}
```

This is the full file.
```rust,no_run,noplaypen
\{{#include file.rs:all}}
```
````

在已 include anchor 内的，若还包含 anchor 匹配模式，则会被忽略。

## 插入可运行的 Rust 文件

使用以下语法,您可以将可运行的 Rust 文件插入到您的书中:

```hbs
\{{#playpen file.rs}}
```

Rust 文件的路径必须是当前源文件的相对路径.

点击播放后,代码段将被发送到[rust 的游乐场][rust playpen]编译和运行。结果被返回，并直接显示在代码下方.

以下是代码段的渲染的样子:

{{#playpen example.rs}}

> 试试 点击 播放箭头

[rust playpen]: https://play.rust-lang.org/

### 要可编辑，请添加

```hbs
\{{#playpen example.rs editable no_run should_panic}}
```

{{#playpen example.rs editable}}
