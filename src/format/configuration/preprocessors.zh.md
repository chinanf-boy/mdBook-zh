## 配置，预处理器

预处理器的作用是，在送进 renderer 之前，修改原始的 Markdown 文本。

内置的有：

- `links`：扩展章节中`{{ #playground }}`和`{{ #include }}`，和 `{{ #rustdoc_include }}` 控制条，能帮助引入文件的内容。查看 [Including files] for more.
- `index`：将所有名为`README.md`的章节文件，转换`index.md`。也就是说，所有`README.md`将被渲染成`index.html`。

内置的预处理器，可以通过[`build.use-default-preprocessors`]禁用。

社区也开发了几个预处理器，可以看看这里[Third Party Plugins]

关于如何创建一个新的预处理器，可以看看[Preprocessors for Developers] 章节。

[including files]: ../mdbook.zh.md#including-files
[`build.use-default-preprocessors`]: general.zh.md#build-options
[third party plugins]: https://github.com/rust-lang/mdBook/wiki/Third-party-plugins
[preprocessors for developers]: ../../for_developers/preprocessors.zh.md

### 自定义预处理器配置

与渲染器一样，预处理器需要有自己的表格(例如`[preprocessor.mathjax]`)。在该部分中，您可以通过向特有表中，添加键值对来将额外配置传递给预处理器.

例如，如果你有个预处理器叫`mdbook-example`那么可以这样

```toml
[preprocessor.example]
```

有了这个配置，mdBook 会执行，`mdbook-example` 的预处理器。

在这上面，还能添加 key-value 的配置。例如，需要额外的配置选项：

```toml
[preprocessor.example]
some-extra-feature = true
```

#### 锁住一个预处理依赖给一个渲染器

您可以通过将两者绑定在一起，显式指定预处理器将运行的渲染器

```toml
[preprocessor.example]
renderers = ["html"]  # example 只 HTML 渲染合作
```

### 添加你的命令

默认情况下，添加`[preprocessor.foo]`到你的`book.toml`文件，`mdbook`将尝试调用`mdbook-foo`启动。如果你想使用不同的程序名 或传递一个命令行参数。这些都能通过`command`字段覆盖完成。

```toml
[preprocessor.random]
command = "python random.py"
```

## 顺序执行

执行的顺序可以通过， `before` 和 `after` 字段完成。
例如：假设你想 `{{#include}}` 之后，再执行`linenos`; 然后，你想在`links` 之后运行，`before` 或 `after` 就派上用场了:

```toml
[preprocessor.linenos]
after = [ "links" ]
```

或

```toml
[preprocessor.links]
before = [ "linenos" ]
```

虽然多余，但也可以在同一个配置文件中，指定上述两者。

具有相同优先级的预处理器通过 `before` 和 `after`，以名字排序。
将检测到任何无限循环并产生错误。
