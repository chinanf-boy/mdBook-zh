# 在持续集成服务器中运行 `mdbook`

有几种集成服务器（CI），比如： [GitHub Actions] or [GitLab CI/CD] ，它们的作用是自动测试和发布你的文档。

接下来，有几个方式配置这些服务器。
更多信息，可看 [Automated Deployment] 。

[github actions]: https://docs.github.com/en/actions
[gitlab ci/cd]: https://docs.gitlab.com/ee/ci/
[automated deployment]: https://github.com/rust-lang/mdBook/wiki/Automated-Deployment

### Pre-compiled binaries

最简单的方式，莫过于去 [GitHub Releases page][releases]，下载执行文件。
使用 `curl` 快速下载:

```sh
mkdir bin
curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.15/mdbook-v0.4.15-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=bin
bin/mdbook build
```

这个方法的几个特点:

- 够快，没有什么缓存。
- 不用安装 Rust。
- 需要自己手动更新
  当然，如果是要锁定某个版本的话，这是一个优势。
  然而，自动更新，也是许多人想要的。
- 搭上 GitHub CDN。

[releases]: https://github.com/rust-lang/mdBook/releases

### Building from source

这个方式，要求安装了 Rust。
会有些服务器是安装的, 但如果没有，你需要加安装 Rust 的步骤。

一旦 Rust 安装上了, `cargo install` 下载和构建 mdBook。.
强烈建议使用 SemVer 版本语法，这样你就能得到一个 **non-breaking** 版本的 mdBook。
For example:

```sh
cargo install mdbook --no-default-features --features search --vers "^0.4" --locked
```

其中，包含了几项建议:

- `--no-default-features` — 禁掉默认功能，比如：`mdbook serve`命令需要的 HTTP server，这些在 CI 上都是不需要的。加速构建。
- `--features search` — 禁用了默认功能，意味着你要指定功能，比如，搜寻 [search] 就挺有用的。
- `--vers "^0.4"` — 会下载与 `0.4` 最为接近的版本。
  但是，像 `0.5.0`之后的版本就不会安装。因为，它们有可能不兼容。
  Cargo 会帮你自动升级。

- `--locked` — 锁定依赖的版本，要是没有 `--locked`, 所有的依赖就会用最新的版本。即可能是 bug 修复，也可能导致构建问题。

最好看看，关于缓存的选项，能帮你的构建节省时间。

[search]: guide/reading.zh.md#search

## Running tests

[`mdbook test`] 会测试你的 Rust 测试代码。也用来测试书内的代码示例。

这个方式，要求安装了 Rust。
会有些服务器是安装的, 但如果没有，你需要加安装 Rust 的步骤。

除了，恰当的 Rust 版本，和`mdbook test`，你已然不需要其他的了。

当然，若是你像运行其他测试，像 [mdbook-linkcheck] 检查，网络链接的完整.
或是 样式，拼写啊，杂七杂八的测试啊，都可以在 CI 上，搞定。

[`mdbook test`]: cli/test.md.md
[mdbook-linkcheck]: https://github.com/Michael-F-Bryan/mdbook-linkcheck#continuous-integration

## Deploying

自动发布的功能，有些人希望每次改变就来一次；当然，也特殊 tag 再来一次，这些都可以做到。

或许，你还想了解下，如何推送新改变的。
例如, [GitHub Pages] 仅仅像正常 push 下，就自动搞定。

下一步，自然是 `mdbook build`，生成内容，输出到目标目录 (默认是，当地的 `book` 目录) 。

更多请看 [Automated Deployment] ，上面有多个不同示例。

[github pages]: https://docs.github.com/en/pages

### 404 handling

错误链接就给 404 页面。默认名称就是 `404.html` 。
像 [GitHub Pages] ，就会自动跳转。
其他，可能需要配置配置。

如果你的书，不是放置在顶层网址上，那么 [`output.html.site-url`] 必不可少。
书用到的静态文件 (like CSS) ，都是需要正确获取的。
就好比，这本书 <https://chinanf-boy.github.io/mdBook-zh/>, 那么 `site-url` 就是：

```toml
# book.toml
[output.html]
site-url = "/mdBook-zh/"
```

自定义 404 页面也是可以的，比如： `src/404.md`。
当然，对应要配置下[`output.html.input-404`] 。

[`output.html.site-url`]: format/configuration/renderers.zh.md#html-renderer-options
[`output.html.input-404`]: format/configuration/renderers.zh.md#html-renderer-options
