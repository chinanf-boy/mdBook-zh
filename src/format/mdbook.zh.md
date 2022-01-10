# mdBook 特有 markdown

## 隐藏代码行数

mdBook 中有一个功能，可以通过在代码行前加上`#`来隐藏代码行，[像在 Rustdoc 一样][rustdoc-hide]。目前只适用 Rust 代码。

[rustdoc-hide]: https://doc.rust-lang.org/stable/rustdoc/documentation-tests.html#hiding-portions-of-the-example

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
    let y = 6;

    println!("{}", x + y);
# }
```

这个代码块会有一个眼睛的图标 (<i class="fa fa-eye"></i>) ，控制那些隐藏的代码行。

## Rust Playground

Rust language 会有一个 (<i class="fa fa-play"></i>) w 按钮，调用 API，执行 rust 代码。
具体是发送给 [Rust Playground]，从而获取结果。

```rust
println!("Hello, World!");
```

如果没有 `main` 函数，自动包裹进入。

不想有运行按钮，你要加上 `noplayground` ：

````markdown
```rust,noplayground
let mut name = String::new();
std::io::stdin().read_line(&mut name).expect("failed to read line");
println!("Hello {}!", name);
```
````

## Rust code block attributes

额外的选项，可以通过 逗号，空格，tab 分隔。例如：

````markdown
```rust,ignore
# This example won't be tested.
panic!("oops!");
```
````

用[`mdbook test`] 去测试 Rust 代码时，尤为重要。
会用到与 [rustdoc attributes]相同的选项，如下：

- `editable` — 启用 [editor]。
- `noplayground` — 移除运行按钮，但仍会测试。
- `mdbook-runnable` — 强制具备，运行按钮
  主要是搭配`ignore` 使用。例如代码没有被测试, 但你又想运行它。
- `ignore` — 既不测试，也不能运行，只剩下语法高亮。
- `should_panic` — 应该给出一个 panic
- `no_run` — 测试时编译，但不运行。
  运行按钮也不会出现。
- `compile_fail` — 代码应该编译失败。
- `edition2015`, `edition2018`, `edition2021` — 强制使用特定的版本。
  可以用 [`rust.edition`] ，全局设置。

[`mdbook test`]: ../cli/test.zh.md
[rustdoc attributes]: https://doc.rust-lang.org/rustdoc/documentation-tests.html#attributes
[editor]: theme/editor.zh.md
[`rust.edition`]: configuration/general.zh.md#rust-options

## include，包含文件内容

使用以下语法，您可以将文件包含到您的书中:

```hbs
\{{#include file.rs}}
```

文件的路径必须是 **当前** 源文件的 **相对** 路径.

通常，此命令用于包含代码段和示例。在这种情况下， 可指定文件的包含部分，例如其中只包含示例的相关行.

mdBook 会将 include 文件 解释成 markdown。 自从 include 命令常用来插入代码片段和示例，你会习惯使用 ` ``` ` 包裹这些命令，显示（include）文件的内容，而不是去解释它们。

````hbs
```
\{{#include file.rs}} ```
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
- 第二个命令包含直到第 10 行的所有行。即，从 11 到文件末尾的行被省略.
- 第三个命令包含第 2 行的所有行，即省略第一行.
- 最后一个命令包含摘录`file.rs`由 2 到 10 行组成.

为了防止文件的修改（行数的变化），导致图书呈现内容的变化， 你还可以使用锚点(anchor)，选择一个特定的部分，
行数就不再相关。
一个 anchor 是一对匹配的行。 匹配的内容正是正则式，如开头的行 anchor 必须匹配 `ANCHOR:\s*[\w_-]+` and similarly 结尾行则是 `ANCHOR_END:\s*[\w_-]+`。只要内容匹配了，注释的写法格式倒是没有限制。

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
Here is a component: ```rust,no_run,noplayground
\{{#include file.rs:component}} ``` Here is a system:
```rust,no_run,noplayground
\{{#include file.rs:system}} ``` This is the full file.
```rust,no_run,noplayground
\{{#include file.rs:all}} ```
````

在已 include anchor 内的，若还包含 anchor 匹配模式，则会被忽略。

## Including a file but initially hiding all except specified lines

`rustdoc_include` 带有行数，与锚点的属性，其他的就与 `include` 一样。

被过滤的行数，仍会被包含进去，只不过用`#`隐藏了而已。你完全可以显示，隐藏的代码，而 `mdbook test`依旧是执行完全的代码。

例如，`file.rs` 包含下面的 Rust 代码:

```rust
fn main() {
    let x = add_one(2);
    assert_eq!(x, 3);
}

fn add_one(num: i32) -> i32 {
    num + 1
}
```

只显示第二行:

````hbs
To call the `add_one` function, we pass it an `i32` and bind the returned value
to `x`: ```rust
\{{#rustdoc_include file.rs:2}} ```
````

用`#`完成相同的效果:

````hbs
To call the `add_one` function, we pass it an `i32` and bind the returned value
to `x`: ```rust # fn main() { let x = add_one(2); # assert_eq!(x, 3); # } # # fn
add_one(num: i32) -> i32 { # num + 1 # } ```
````

可以通过点击 ( "expand" 按钮看到剩下的文件):

```rust
# fn main() {
    let x = add_one(2);
#     assert_eq!(x, 3);
# }
#
# fn add_one(num: i32) -> i32 {
#     num + 1
# }
```

## 插入可运行的 Rust 文件

使用以下语法,您可以将可运行的 Rust 文件插入到您的书中:

```hbs
\{{#playground file.rs}}
```

Rust 文件的路径必须是当前源文件的相对路径.

点击播放后,代码段将被发送到[rust 的游乐场][rust playground]编译和运行。结果被返回，并直接显示在代码下方.

以下是代码段的渲染的样子:

{{#playground example.rs}}

> 试试 点击 播放箭头

[rust playground]: https://play.rust-lang.org/

### 要可编辑，请添加

```hbs
\{{#playground example.rs editable no_run should_panic}}
```

{{#playground example.rs editable}}

额外属性的添加：`\{{#playground example.rs editable}}` ，它会变成:

````markdown
```rust,editable
# Contents of example.rs here.
```
````

`editable` 会启用 [editor] ，就像[Rust code block attributes](#rust-code-block-attributes)所描述的。

[rust playground]: https://play.rust-lang.org/

## Controlling page \<title\>

可以用 \<title\> 改变边栏的标题：

```hbs
\{{#title My Title}}
```
