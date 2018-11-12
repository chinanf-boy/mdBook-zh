# The serve command

serve命令用于通过HTTP服务来预览书籍`localhost:3000`默认情况下.此外,它还会查看图书的目录以进行更改,重建图书以及为每次更改刷新客户端.websocket连接用于触发客户端刷新.

***注意:*** *该`serve`命令用于测试书籍的HTML输出,并不打算成为网站的完整HTTP服务器.*

#### Specify a directory

该`serve`命令可以将目录作为参数用作本书的根目录而不是当前工作目录.

```bash
mdbook serve path/to/book
```

#### Server options

`serve`有四个选项:HTTP端口,WebSocket端口,要侦听的HTTP主机名,以及要连接到WebSockets的浏览器的主机名.

例如:假设您有一个用于SSL终止的nginx服务器,其端口80上的公共地址为192.168.1.100,并在端口8000上代理为127.0.0.1.要运行使用nginx代理,请执行以下操作:

```bash
mdbook serve path/to/book -p 8000 -n 127.0.0.1 --websocket-hostname 192.168.1.100
```

如果你想要为此实时重新加载,你需要通过nginx来代理websocket调用`192.168.1.100:<WS_PORT>`至`127.0.0.1:<WS_PORT>`.该`-w`flag允许配置websocket端口.

#### --open

当你使用`--open`(`-o`)标志,mdbook将在启动服务器后在您的默认Web浏览器中打开该书.

#### --dest-dir

该`--dest-dir`(`-d`)选项允许您更改书籍的输出目录.相对路径相对于书籍的根目录进行解释.如果未指定,则默认为该值`build.build-dir`键入`book.toml`, 或者`./book`.
