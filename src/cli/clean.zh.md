# The clean command

clean命令用于删除生成的书籍和任何其他构建工件.

```bash
mdbook clean
```

#### Specify a directory

该`clean`命令可以将目录作为参数用作本书的根目录而不是当前工作目录.

```bash
mdbook clean path/to/book
```

#### --dest-dir

该`--dest-dir`(`-d`)选项允许您覆盖书籍的输出目录,该目录将被此命令删除.相对路径相对于书籍的根目录进行解释.如果未指定,则默认为该值`build.build-dir`键入`book.toml`, 或者`./book`.

```bash
mdbook clean --dest-dir=path/to/book
```

`path/to/book`可以是绝对的或相对的.
