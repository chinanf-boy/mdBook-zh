# watch 命令

当您希望在每次更改文件，都生成图书时， `watch`命令会很有用。你当然可以在每次更改文件反复发出`mdbook build`。但，聪明的是使用`mdbook watch`，这样就能观察您的文件，并会在您修改文件时，自动触发构建。
其中包括，那么删除掉，但仍在`SUMMARY.md`里的文件。

#### 指定目录

`watch`命令可以将目录作为参数，用作本书的根目录，而不是当前工作目录.

```bash
mdbook watch path/to/book
```

#### --open

当你使用`--open`(`-o`)选项，mdbook 将在您的默认 Web 浏览器中打开网页书.

#### --dest-dir

`--dest-dir`(`-d`)选项允许您更改书籍的输出目录。为相对路径，（相对于书籍的根目录）。如果未指定，则默认为`book.toml`配置的`build.build-dir`字段， 或者`./book`目录.

#### 指定排除的模式

`watch` 对 `.gitignore` 里的文件，不会触发构建命令。`.gitignore` 是有匹配模式的文件 [gitignore
documentation](https://git-scm.com/docs/gitignore)。忽略那些缓存文件就挺有用的。

_注意: 只有项目的顶层`.gitignore`是工作的。 全局的
`$HOME/.gitignore` or 上级文件夹的`.gitignore` 都不起作用_
