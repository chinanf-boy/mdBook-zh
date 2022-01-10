# 配置

您可以在 **_book.toml_** 文件中配置图书的参数.

这是一个 **_book.toml_** 文件示例，如下所示:

```toml
[book]
title = "Example book"
author = "John Doe"
description = "The example book covers examples."

[build]
build-dir = "my-example-book"
create-missing = false

[preprocessor.index]

[preprocessor.links]

[output.html]
additional-css = ["custom.css"]

[output.html.search]
limit-results = 15
```

## 支持的配置选项

重要的是要注意到，配置中指定的**任何**相对路径，都是相对于配置文件所在的书籍的根目录.

### 通用元数据

这是有关您图书的一般

| 信息            | 描述                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------ |
| **title**       | 这本书的标题                                                                               |
| **author**      | 本书的作者                                                                                 |
| **description** | 该书的描述,作为元信息,添加在每页 html 的`<head>`                                           |
| **src**         | 默认情况下,源目录位于名为`src`的目录中(在根文件夹)。但这`src`是可配置的，就在`book.toml`。 |
| **language:**   | 国家语言, 例如用在网页的 `<html lang="en">` 属性。                                         |

**book.toml**

```toml
[book]
title = "Example book"
authors = ["John Doe", "Jane Doe"]
description = "The example book covers examples."
src = "my-src"  # 源文件夹，用 `root/my-src` 替代 `root/src`
language = "zh-CN"
```

### Rust options

Rust 语言的选项，与运行测试和集成相关。

```toml
[rust]
edition = "2015"   # 默认版本
```

- **版本**：默认情况下用于代码段的 Rust edition。默认值为`2015`。单个代码块可以通过`edition2015`, `edition2018`或`edition2021`注释，例如：

  ````text
  ```rust,edition2015
  // This only works in 2015.
  let try = true;
  ```
  ````

### Build 选项

这可以控制您图书的构建过程.

```toml
[build]
build-dir = "book"                # the directory where the output is placed
create-missing = true             # whether or not to create missing pages
use-default-preprocessors = true  # use the default preprocessors
```

- **build-dir** | 放置渲染图书的目录。默认情况下在根目录的`book/`:
- **create-missing** | 默认情况(`create-missing = true`)下，在书籍建成时，会创建`SUMMARY.md`中缺失的文件。如果是`false`，则有文件不存在,那么构建过程将以错误退出。
- **use-default-preprocessors** | 设为 `false`，会禁用(`links`&`index`)的默认预处理器。

  如果您通过配置文件声明了，相同的和/或其他预处理器,由它们主导.

  - 为清楚起见,没有预处理器配置,默认`links`和`index`运行.
  - 设置`use-default-preprocessors = false`，将禁用这些默认预处理器运行.
  - 若添加`[preprocessor.links]`，那无论如何,都能确保`use-default-preprocessors`运行`links`。
