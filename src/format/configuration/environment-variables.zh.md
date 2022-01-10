## 环境 变量

通过设置相应的环境变量，命令行的运行，覆盖到所有配置值。因为许多操作系统将环境变量限制为`_`字母数字字符，配置字段需要格式化成，正常情况的`foo.bar.baz`形式。

变量以`MDBOOK_`开头配置。通过删除`MDBOOK_`前缀，并将结果字符串转换为`kebab-case`。双下划线(`__`)变`.` ，而单个下划线(`_`)用短划线代替(`-`).

例如:

- `MDBOOK_foo` -> `foo`
- `MDBOOK_FOO` -> `foo`
- `MDBOOK_FOO__BAR` -> `foo.bar`
- `MDBOOK_FOO_BAR` -> `foo-bar`
- `MDBOOK_FOO_bar__baz` -> `foo-bar.baz`

所以通过设置`MDBOOK_BOOK__TITLE`环境变量，你可以覆盖书的标题，而无需修改你的`book.toml`.

> **注意** 为了便于设置更复杂的配置项，首先将环境变量的值解析为 JSON，如果解析失败，则返回到字符串.
>
> 这意味着，如果您愿意，可以在构建书籍时覆盖所有书籍元数据
>
> ```shell
> $ export MDBOOK_BOOK="{'title': 'My Awesome Book', authors: ['Michael-F-Bryan']}"
> $ mdbook build
> ```

后一种情况，在以下情况下可能有用，

- 脚本或 CI 调用`mdbook`,
- 有时在构建前，无法更新`book.toml`。
