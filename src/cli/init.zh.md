# The init command

每本新书都有一些最小的样板.为此目的,mdBook包括一个`init`命令.

该`init`命令使用如下:

```bash
mdbook init
```

使用时`init`第一次命令,将为您设置几个文件:

```bash
book-test/
├── book
└── src
    ├── chapter_1.md
    └── SUMMARY.md
```

-   该`src`目录是你在降价时写的书.它包含所有源文件,配置文件等.

-   该`book`目录是您的图书呈现的位置.所有输出都可以上传到服务器,供观众查看.

-   该`SUMMARY.md`文件是最重要的文件,它是您图书的骨架,并将进行更详细的讨论[in another
    chapter](../format/summary.md)

#### Tip: Generate chapters from SUMMARY.md

当一个`SUMMARY.md`文件已存在,`init`命令将首先解析它并根据中使用的路径生成丢失的文件`SUMMARY.md`.这允许您思考和创建书的整个结构,然后让mdBook为您生成它.

#### Specify a directory

该`init`命令可以将目录作为参数用作本书的根目录而不是当前工作目录.

```bash
mdbook init path/to/book
```

#### --theme

当你使用`--theme`flag,默认主题将被复制到一个名为的目录中`theme`在您的源目录中,以便您可以修改它.

主题被选择性地覆盖,这意味着如果您不想覆盖特定文件,只需删除它,就会使用默认文件.
