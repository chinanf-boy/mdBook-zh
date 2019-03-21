# mdBook特有 markdown

## 隐藏代码行数

mdBook中有一个功能,可以通过在代码行前加上`#`来隐藏代码行.

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

```hbs
\{{#include file.rs:2}}
\{{#include file.rs::10}}
\{{#include file.rs:2:}}
\{{#include file.rs:2:10}}
```

我们支持四种不同的决定`file.rs`部分模式:

- 第一个命令仅包含文件中的第二行.
- 第二个命令包含直到第10行的所有行。即,从11到文件末尾的行被省略.
- 第三个命令包含第2行的所有行,即省略第一行.
- 最后一个命令包含摘录`file.rs`由2到10行组成.

## 插入可运行的Rust文件

使用以下语法,您可以将可运行的Rust文件插入到您的书中:

```hbs
\{{#playpen file.rs}}
```

Rust文件的路径必须是当前源文件的相对路径.

点击播放后,代码段将被发送到[rust的游乐场][rust playpen]编译和运行。结果被返回，并直接显示在代码下方.

以下是代码段的渲染的样子:

{{#playpen example.rs}}

> 试试 点击 播放箭头

[rust playpen]: https://play.rust-lang.org/

### 要可编辑，请添加

```hbs
\{{#playpen example.rs editable no_run should_panic}}
```

{{#playpen example.rs editable}}
