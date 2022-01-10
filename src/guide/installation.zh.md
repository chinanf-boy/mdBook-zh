# Installation

安装 mdBook CLI 工具有多种方法。选择下面最适合您需要的任何一种方法。如果要安装 mdBook，是为了自动部署，请查看 [持续集成][continuous integration] 有关如何安装的更多示例。。

[continuous integration]: ../continuous-integration.zh.md

## Pre-compiled binaries

可执行二进制文件，可在[GitHub Releases page][releases]下载。选择适用于您的平台（Windows、macOS 或 Linux）的二进制文件，下载后解压缩存档。存档包含一个`mdbook`可执行文件，您可以运行它，来构建书籍。

为了便于运行，请将二进制文件的路径放入`PATH`.

[releases]: https://github.com/rust-lang/mdBook/releases

## Build from source using Rust

可从源代码构建`mdbook`，您首先需要安装 Rust 和 Cargo。按照屏幕上的说明操作[Rust installation page]。mdBook 当前至少需要 Rust 1.46。

安装 Rust 后，可以使用以下命令，构建和安装 mdBook：

```sh
cargo install mdbook
```

这将自动从[crates.io]下载 mdBook，构建并安装在 Cargo 的全局二进制目录中(默认情况下，`~/.cargo/bin/`）。

[rust installation page]: https://www.rust-lang.org/tools/install
[crates.io]: https://crates.io/

### Installing the latest master version

发布到 crates.io 的箱子版本，稍微落后于 GitHub 上托管的版本。如果您需要最新版本，您可以自己构建 mdBook 的 git 版本。cargo 构建起来**_超级容易_**!

```sh
cargo install --git https://github.com/rust-lang/mdBook.git mdbook
```

同样，确保将命令行 cargo 的目录添加到您的`PATH`.

如果您对修改 mdBook 本身感兴趣，请查看[Contributing Guide]了解更多信息。

[contributing guide]: https://github.com/rust-lang/mdBook/blob/master/CONTRIBUTING.md
