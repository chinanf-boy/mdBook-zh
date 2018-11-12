# The watch command

该`watch`当您希望在每次更改文件时呈现图书时,命令很有用.你可以反复发出`mdbook build`每次更改文件.但是使用`mdbook watch`一旦您将观看您的文件,并会在您修改文件时自动触发构建.

#### Specify a directory

该`watch`命令可以将目录作为参数用作本书的根目录而不是当前工作目录.

```bash
mdbook watch path/to/book
```

#### --open

当你使用`--open`(`-o`)选项,mdbook将在您的默认Web浏览器中打开呈现的书.

#### --dest-dir

该`--dest-dir`(`-d`)选项允许您更改书籍的输出目录.相对路径相对于书籍的根目录进行解释.如果未指定,则默认为该值`build.build-dir`键入`book.toml`, 或者`./book`.
