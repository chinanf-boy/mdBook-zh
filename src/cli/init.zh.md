# init 命令

每本新书都有一些最小的样板。为此目的,mdBook 支持`init`命令.

`init`命令使用如下:

```bash
mdbook init
```

第一次使用`init`命令,将为您设置几个文件:

```bash
book-test/
├── book
└── src
    ├── chapter_1.md
    └── SUMMARY.md
```

- `src`目录是你在写的 markdown 书。它包含所有源文件,配置文件等.

- `book`目录是您的书 html 页面输出的位置。所有输出都可以上传到服务器,供观众查看.

- `SUMMARY.md`文件是您图书的骨架,并将在[其他章节](../format/summary.zh.md)进行更详细的讨论

#### Tip: 根据 SUMMARY.md 生成

当一个`SUMMARY.md`文件已存在,`init`命令将首先解析它，并根据`SUMMARY.md`中，帮其补全丢失的文件路径。这允许您思考和创建书的整个结构,然后让 mdBook 为您生成它.

#### 指定目录

`init`命令可以将目录作为参数，用作本书的根目录，而不是当前工作目录.

```bash
mdbook init path/to/book
```

#### --theme

当你使用`--theme`,默认主题将被复制到一个名为`theme`的目录.

> 在您的源目录中,以便您可以修改它.

主题会被选择性地覆盖,这意味着如果您不想覆盖,只需删除它,就会使用默认文件.

#### --title

指定书的标题。没有的话，它会问你

```bash
mdbook init --title="my amazing book"
```

#### --ignore

创建一个 `.gitignore`，忽略[构建][building]的目录。
没有的话，它会问你

[building]: build.zh.md
