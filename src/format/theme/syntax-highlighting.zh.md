# 语法高亮

mdBook 使用[Highlight.js](https://highlightjs.org)自定义主题，完成语法高亮的功能。

自动语言检测已关闭，因此您可能希望指定您使用的编程语言

````markdown
```rust
fn main() {
    // Some code
}
```
````

## Supported languages

这些是默认支持的语言，你还可以通过应用你的`highlight.js` 文件，达到添加的作用:

- apache
- armasm
- bash
- c
- coffeescript
- cpp
- csharp
- css
- d
- diff
- go
- handlebars
- haskell
- http
- ini
- java
- javascript
- json
- julia
- kotlin
- less
- lua
- makefile
- markdown
- nginx
- objectivec
- perl
- php
- plaintext
- properties
- python
- r
- ruby
- rust
- scala
- scss
- shell
- sql
- swift
- typescript
- x86asm
- xml
- yaml

## 自定义主题

与主题的其余部分一样,用于语法突出显示的 css，可以使用您自己的文件覆盖.

- **_highlight.js_** 通常你不应该覆盖这个文件,除非你想使用更新的版本.
- **_highlight.css_** highlight.js 用于语法高亮的主题.

如果你想使用`highlight.js`另一个主题,可从他们的网站下载,或自己制作,重命名为`highlight.css`，并把它放进去根目录下的`theme`

现在将使用您的主题，而不是默认主题.

## 隐藏代码行数

mdBook 中有一个功能,可以通过在代码行前加上来隐藏代码行`#`.

```bash
# fn main() {
    let x = 5;
    let y = 6;

    println!("{}", x + y);
# }
```

将渲染为

```rust
# fn main() {
    let x = 5;
    let y = 7;

    println!("{}", x + y);
# }
```

**目前,这仅适用于带注释的代码示例`rust`。因为它会与某些编程语言的语义冲突.在未来,我们希望通过这个，可在`book.toml`配置，这样每个人都可以从中受益.**

## 加强默认主题

如果您认为默认主题看起来不适合特定语言,或者可以改进。随意地[submit a new
issue](https://github.com/rust-lang/mdBook/issues)解释你的想法，我会看看它.

您还可以使用建议的改进创建拉取请求.

总的来说，主题应该是清淡和清醒，没有许多华丽的颜色.
