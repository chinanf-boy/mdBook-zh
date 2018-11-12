# The test command

写书时,有时需要自动化一些测试.例如,[The Rust Programming Book](https://doc.rust-lang.org/stable/book/)使用了许多可能过时的代码示例.因此,能够自动测试这些代码示例对他们来说非常重要.

mdBook支持`test`将运行书中所有可用测试的命令.目前,只支持rustdoc测试,但未来可能会扩展.

#### Disable tests on a code block

rustdoc不测试包含的代码块`ignore`属性:

````
```rust,ignore
fn main() {}
```
````

rustdoc也不测试指定除Rust之外的语言的代码块:

````
```markdown
**Foo**: _bar_
```
````

rustdoc*不*测试没有指定语言的代码块:

````
```
This is going to cause an error!
```
````

#### Specify a directory

该`test`命令可以将目录作为参数用作本书的根目录而不是当前工作目录.

```bash
mdbook test path/to/book
```

#### --library-path

该`--library-path`(`-L`)选项允许您将目录添加到使用的库搜索路径`rustdoc`当它构建和测试示例时.可以使用多个选项指定多个目录(`-L foo -L bar`)或用逗号分隔的列表(`-L foo,bar`).

#### --dest-dir

该`--dest-dir`(`-d`)选项允许您更改书籍的输出目录.相对路径相对于书籍的根目录进行解释.如果未指定,则默认为该值`build.build-dir`键入`book.toml`, 或者`./book`.
