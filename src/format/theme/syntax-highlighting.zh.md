# Syntax Highlighting

对于我使用的语法高亮[Highlight.js](https://highlightjs.org)自定义主题.

自动语言检测已关闭,因此您可能希望指定您使用的编程语言

<pre><code class="language-markdown">```rust
fn main() {
    // Some code
}
```</code></pre>

## Custom theme

与主题的其余部分一样,用于语法突出显示的文件可以使用您自己的文件覆盖.

-   ***highlight.js***通常你不应该覆盖这个文件,除非你想使用更新的版本.
-   ***highlight.css***highlight.js用于语法高亮的主题.

如果你想使用另一个主题`highlight.js`从他们的网站下载,或自己制作,重命名为`highlight.css`并把它放进去`src/theme`(或等效的,如果您更改了源文件夹)

现在将使用您的主题而不是默认主题.

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

**目前,这仅适用于带注释的代码示例`rust`.因为它会与某些编程语言的语义冲突.在未来,我们希望通过这个可配置`book.toml`这样每个人都可以从中受益.**

## Improve default theme

如果您认为默认主题看起来不适合特定语言,或者可以改进.随意地[submit a new
issue](https://github.com/rust-lang-nursery/mdBook/issues)解释你的想法,我会看看它.

您还可以使用建议的改进创建拉取请求.

总的来说,主题应该是清淡和清醒,没有许多华丽的颜色.
