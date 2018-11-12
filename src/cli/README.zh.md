# Command Line Tool

mdBook既可以用作命令行工具,也可以用作命令行工具[Rust
crate](https://crates.io/crates/mdbook).让我们首先关注命令行工具功能.

## Install From Binaries

预先编译的二进制文件是在尽力而为的基础上为主要平台提供的.访问[the releases page](https://github.com/rust-lang-nursery/mdBook/releases)下载适合您平台的版本.

## Install From Source

mdBook也可以从源代码安装

### Pre-requisite

mdBook是写的**[Rust](https://www.rust-lang.org/)**因此需要编译**货物**.如果您还没有安装Rust,请继续[install it](https://www.rust-lang.org/downloads.html)现在.

### Install Crates.io version

如果您已安装Rust和Cargo,则安装mdBook相对容易.您只需在终端中键入以下代码段:

```bash
cargo install mdbook
```

这将获取最新版本的源代码[Crates.io](https://crates.io/)并编译它.你将不得不添加货物`bin`你的目录`PATH`.

跑`mdbook help`在您的终端验证它是否有效.恭喜你,你已经安装了mdBook!

### Install Git version

该**[git version](https://github.com/rust-lang-nursery/mdBook)**包含所有最新的错误修复和功能,将在下一个版本中发布**Crates.io**,如果你不能等到下一个版本.你可以自己构建git版本.打开终端并导航到您选择的目录.我们需要克隆git存储库,然后使用Cargo构建它.

```bash
git clone --depth=1 https://github.com/rust-lang-nursery/mdBook.git
cd mdBook
cargo build --release
```

可执行文件`mdbook`将在`./target/release`文件夹,这应该添加到路径中.
