# The serve command

serve 命令用于通过 HTTP 服务来预览书籍，默认情况下`localhost:3000`。

```bash
mdbook serve
```

`serve` 观察 `src` 目录的变化，对每次变化，都会执行重建与刷新客户端;
还包括重新创建已删除，但仍在 `SUMMARY.md`里的文件! 一个 websocket 连接用于触发客户端刷新.

**_注意:_** _`serve`命令用于测试书籍的 HTML 输出,并不打算成为网站的完整 HTTP 服务器._

#### 指定目录

`serve`命令可以将目录作为参数，用作本书的根目录，而不是当前工作目录.

```bash
mdbook serve path/to/book
```

#### Server 选项

`serve` 默认端口：`localhost:3000`；或是通过下面命令改变：

```bash
mdbook serve path/to/book -p 8000 -n 127.0.0.1 
```

#### --open

当你使用`--open`(`-o`)标志,mdbook 将在启动服务器后,在您的默认 Web 浏览器中打开该书.

#### --dest-dir

`--dest-dir`(`-d`)选项允许您更改书籍的输出目录。为相对路径，（相对于书籍的根目录）。如果未指定,则默认为`book.toml`配置的`build.build-dir`字段, 或者`./book`目录.

#### 指定排除的模式

`watch` 对 `.gitignore` 里的文件，不会触发构建命令。`.gitignore` 是有匹配模式的文件 [gitignore
documentation](https://git-scm.com/docs/gitignore)。忽略那些缓存文件就挺有用的。

_注意: 只有项目的顶层`.gitignore`是工作的。 全局的
`$HOME/.gitignore` or 上级文件夹的`.gitignore` 都不起作用_
