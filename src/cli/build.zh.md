# The build command

构建命令用于呈现您的书:

```bash
mdbook build
```

它会尝试解析你的`SUMMARY.md`文件以了解您的图书的结构并获取相应的文件.

为方便起见,渲染的输出将保持与源相同的目录结构.因此,大型书籍在呈现时将保持结构化.

#### Specify a directory

该`build`命令可以将目录作为参数用作本书的根目录而不是当前工作目录.

```bash
mdbook build path/to/book
```

#### --open

当你使用`--open`(`-o`)标志,mdbook将在构建之后在默认Web浏览器中打开呈现的书.

#### --dest-dir

该`--dest-dir`(`-d`)选项允许您更改书籍的输出目录.相对路径相对于书籍的根目录进行解释.如果未指定,则默认为该值`build.build-dir`键入`book.toml`, 或者`./book`.

* * *

***注意:*** *确保在根目录中运行build命令,而不是在源目录中运行*
