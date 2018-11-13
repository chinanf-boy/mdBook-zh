# The serve command

serve 命令用于通过 HTTP 服务来预览书籍，默认情况下`localhost:3000`。此外,它还会观察图书的目录的更改,自动重建图书，以及为每次更改刷新客户端。

> websocket 连接用于触发客户端刷新.

**_注意:_** _`serve`命令用于测试书籍的 HTML 输出,并不打算成为网站的完整 HTTP 服务器._

#### 指定目录

`serve`命令可以将目录作为参数，用作本书的根目录，而不是当前工作目录.

```bash
mdbook serve path/to/book
```

#### Server 选项

`serve`有四个选项:
- HTTP 端口,
- WebSocket 端口,
- 要侦听的 HTTP 主机名,以及
- 要连接到 WebSockets 的浏览器的主机名.

例如:假设您有一个公共地址为 192.168.1.100，可用 SSL 终止符 的 nginx 服务器,其端口 80 , 在127.0.0.1的 8000端口 上代理。要运行使用 nginx 代理,请执行以下操作:

```bash
mdbook serve path/to/book -p 8000 -n 127.0.0.1 --websocket-hostname 192.168.1.100
```

如果你想要实时重新加载,你需要通过 nginx 来代理 websocket 调用`192.168.1.100:<WS_PORT>`到`127.0.0.1:<WS_PORT>`。

`-w`选项会允许配置 websocket 端口.

#### --open

当你使用`--open`(`-o`)标志,mdbook 将在启动服务器后,在您的默认 Web 浏览器中打开该书.


#### --dest-dir

`--dest-dir`(`-d`)选项允许您更改书籍的输出目录。为相对路径，（相对于书籍的根目录）。如果未指定,则默认为`book.toml`配置的`build.build-dir`字段, 或者`./book`目录.
