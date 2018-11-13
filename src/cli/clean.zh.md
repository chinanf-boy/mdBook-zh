# clean 命令

clean 命令用于删除生成的书籍，和任何其他构建工件.

```bash
mdbook clean
```

#### 指定目录

`clean`命令可以将目录作为参数，用作本书的根目录，而不是当前工作目录.

```bash
mdbook clean path/to/book
```

#### --dest-dir

`--dest-dir`(`-d`)选项允许您覆盖书籍的输出目录,该目录会删除。
为相对路径，（相对于书籍的根目录）。如果未指定,则默认为`book.toml`配置的`build.build-dir`字段, 或者`./book`目录.

```bash
mdbook clean --dest-dir=path/to/book
```

`path/to/book`可以是绝对的，或相对的.
