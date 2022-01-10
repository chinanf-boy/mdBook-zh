# Command Line Tool

mdBook既可以用作命令行工具,也可以用作[Rust
crate](https://crates.io/crates/mdbook)。让我们首先关注命令行工具功能.

## 二进制

在尽力而为的基础上,预先编译主要平台的二进制文件。访问[ releases 页面](https://github.com/rust-lang/mdBook/releases)下载适合您平台的版本.

## 源码安装

mdBook也可以从源代码安装

### Pre-requisite

mdBook是写的 **[Rust](https://www.rust-lang.org/)** 因此需要**Cargo**编译。如果您还没有安装Rust，请现在就[官方安装](https://www.rust-lang.org/zh-CN/tools/install)。

### 安装 Crates.io 的版本

如果您已安装Rust和Cargo,则安装mdBook相当容易。您只需在终端中键入以下代码段:

```bash
cargo install mdbook
```

这将在[Crates.io](https://crates.io/)获取最新版本的源代码，并编译它。你需要添加Cargo的`bin`目录，到你的环境变量`PATH`.

在您的终端，运行`mdbook help`验证它是否有效。

恭喜你,你已经安装了mdBook!

### 安装 Git 版本

该 **[git 版本](https://github.com/rust-lang/mdBook)** 包含所有最新的错误修复和功能, 且是在下一个版本中才发布**Crates.io**, 如果你不能等到下一个版本。你可以自己构建git版本。打开终端，并导航到您选择的目录。我们需要克隆git存储库,然后使用Cargo构建它.

```bash
git clone --depth=1 https://github.com/rust-lang/mdBook.git
cd mdBook
cargo build --release
```

可执行文件`mdbook`输出在`./target/release`文件夹,这应该添加到环境变量`PATH`中，方便使用。
