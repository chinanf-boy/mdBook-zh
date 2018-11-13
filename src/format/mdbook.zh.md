# mdBook-specific markdown

## Hiding code lines

mdBook中有一个功能,可以通过在代码行前加上来隐藏代码行`#`.

```bash
# fn main() {
    let x = 5;
    let y = 6;

    println!("{}", x + y);
# }
```

将呈现为

```rust
# fn main() {
    let x = 5;
    let y = 7;

    println!("{}", x + y);
# }
```

## Including files

使用以下语法,您可以将文件包含到您的书中:

```hbs
\{{#include file.rs}}
```

文件的路径必须是当前源文件的相对路径.

通常,此命令用于包括代码段和示例.在这种情况下,一个人将包括文件的特定部分,例如其中只包含示例的相关行.

```hbs
\{{#include file.rs:2}}
\{{#include file.rs::10}}
\{{#include file.rs:2:}}
\{{#include file.rs:2:10}}
```

我们支持四种不同的部分模式:`file.rs`第一个命令仅包含文件中的第二行.第二个命令包括直到第10行的所有行.即,从11到文件末尾的行被省略.

第三个命令包括第2行的所有行,即省略第一行.最后一个命令包括摘录`file.rs`由2到10行组成.

## Inserting runnable Rust files

使用以下语法,您可以将可运行的Rust文件插入到您的书中:

```hbs
\{{#playpen file.rs}}
```

Rust文件的路径必须是当前源文件的相对路径.

点击播放后,代码段将被发送到[生锈的围栏]编译和运行.结果将被发回并直接显示在代码下方.

以下是呈现的代码段的样子:

{{#playpen example.rs}}

[rust playpen]: https://play.rust-lang.org/
