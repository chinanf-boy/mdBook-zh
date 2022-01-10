# test 命令

写书时，有时需要一些自动化测试。例如，[The Rust Programming Book](https://doc.rust-lang.org/stable/book/)使用了许多可能过时的代码示例。因此，能够自动测试这些代码示例对他们来说非常重要。

mdBook 支持`test`将运行，书中所有可用测试的命令。目前，只支持 rustdoc 测试，但未来可能会扩展。

#### 在一个代码块，禁用测试

rustdoc 不会测试，包含`ignore`属性的代码块:

```rust,ignore
fn main() {}
```

rustdoc 也不会测试，指定了除 Rust 之外的语言的代码块:

```markdown
**Foo**: _bar_
```

rustdoc*不会*测试，没有指定语言的代码块:

```
This is going to cause an error!
```

#### 指定目录

`test`命令可以将目录作为参数，用作本书的根目录，而不是当前工作目录.

```bash
mdbook test path/to/book
```

#### --library-path

`--library-path`(`-L`)选项允许您，当`rustdoc`构建和测试示例时，将目录添加到搜索路径。可以指定多个目录(`-L foo -L bar`)，或用逗号分隔的列表(`-L foo,bar`)。路径应该指向 Cargo
[build cache](https://doc.rust-lang.org/cargo/guide/build-cache.html) `deps` 目录，在其中包含了项目的输出。例如：你的目录叫 `my-book`, 下面的测试命令就可以带上 crate 的 依赖:

```shell
mdbook test my-book -L target/debug/deps/
```

See the `rustdoc` command-line [documentation](https://doc.rust-lang.org/rustdoc/command-line-arguments.html#-l--library-path-where-to-look-for-dependencies)
for more information.

#### --dest-dir

`--dest-dir`(`-d`)选项允许您更改书籍的输出目录。为相对路径，（相对于书籍的根目录）。如果未指定,则默认为`book.toml`配置的`build.build-dir`字段, 或者`./book`目录.
