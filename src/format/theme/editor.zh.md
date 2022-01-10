# 编辑器

除了提供可运行的代码 playgrounds 之外，mdBook 还可以选择进行编辑。为了启用可编辑的代码块，需要添加以下内容到**_book.toml_**:

```toml
[output.html.playground]
editable = true
```

要使特定块可用于编辑，请使用该属性`editable`添加:

````markdown
```rust,editable
fn main() {
    let number = 5;
    print!("{}", number);
}
```
````

注意新的`Undo Changes`的按钮会出现在可编辑的 playgrounds 中.

## 定制编辑器

默认情况下，编辑器是[Ace](https://ace.c9.io/)编辑器，但是，如果需要，可以通过提供不同的文件夹来覆盖功能:

```toml
[output.html.playground]
editable = true
editor = "/path/to/editor"
```

请注意，要让编辑器更改正常运行，`book.js`里面的`theme`文件夹，你需要覆盖下，因为它与默认的 Ace 编辑器有一些耦合.
