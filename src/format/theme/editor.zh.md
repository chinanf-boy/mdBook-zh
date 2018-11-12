# Editor

除了提供可运行的代码游戏围栏之外,mdBook还可以选择允许它们进行编辑.为了启用可编辑的代码块,需要添加以下内容***book.toml***:

```toml
[output.html.playpen]
editable = true
```

要使特定块可用于编辑,请使用该属性`editable`需要添加到它:

<pre><code class="language-markdown">```rust,editable
fn main() {
    let number = 5;
    print!("{}", number);
}
```</code></pre>

以上将导致这个可编辑的围栏:

```rust,editable
fn main() {
    let number = 5;
    print!("{}", number);
}
```

注意新的`Undo Changes`可编辑的游戏围栏中的按钮.

## Customizing the Editor

默认情况下,编辑器是[Ace](https://ace.c9.io/)编辑器,但是,如果需要,可以通过提供不同的文件夹来覆盖功能:

```toml
[output.html.playpen]
editable = true
editor = "/path/to/editor"
```

请注意,对于编辑器更改为正常运行,`book.js`里面的`theme`文件夹将需要被覆盖,因为它与默认的Ace编辑器有一些耦合.
