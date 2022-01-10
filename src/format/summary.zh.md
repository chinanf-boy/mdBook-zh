# SUMMARY.md

mdBook 使用 Summary 文件，来了解要书的章节，应显示的顺序，层次结构以及源文件的位置。**没有这个文件，就没有书.**

必须叫`SUMMARY.md`，它是一个 markdown 文件， 但格式是非常严格，以便于给 mdbook 解析。我们来看看你应该如何结构化你的`SUMMARY.md`文件.

#### 结构

1.  **_Title_** 一般来说，通常以<code
    class="language-markdown"># Summary</code>。标题开头是常见的做法，但它不是强制性的，解析器只是忽略它。如果你也是这样想，也忽略它。

    ```markdown
    # Summary
    ```

2.  **_开头章节_** 位于主编号章节前，您可以添加一些不编号的开头章节。这对`前言，介绍`等很有用。但是有一些限制。你不能嵌套开头章节，它们都应该在根级别。一旦添加了编号章节，就无法添加开头章节。

```markdown
[A Prefix Chapter](relative/path/to/markdown.md)

- [First Chapter](relative/path/to/markdown2.md)
```

3. **_Part Title_** - 标题，对书进行逻辑分割。它们渲染成不能点击的。
   它是可选的，然后编号章节可以放在它下面：

   ```markdown
   # My Part Title

   - [First Chapter](relative/path/to/markdown.md)
   ```

4. **_编号章节_** 是本书的主要内容，它们将被编号，并可以嵌套，从而产生一个很好的层次结构(章节，子章节等)

   ```markdown
   # Title of Part

   - [First Chapter](relative/path/to/markdown.md)
   - [Second Chapter](relative/path/to/markdown2.md)
   - [Sub Chapter](relative/path/to/markdown3.md)

   # Title of Another Part

   - [Another Chapter](relative/path/to/markdown4.md)
   ```

   你可以使用`-`或`*`表示编号的章节.

5. **_结尾章节_** 位于在编号章节后，您可以添加几个未编号的章节.它们与开头章节相同，但是在编号章节之后，而不是之前.

    ```markdown
    - [Last Chapter](relative/path/to/markdown.md)

    [Title of Suffix Chapter](relative/path/to/markdown2.md)
    ```

6. **_Draft chapters_** - 草稿章节。
   它的作用就是，给章节的 TODO 字符串。
   这类章节会被渲染，但是一个禁用的链接。
   写法如下：

   ```markdown
   - [Draft Chapter]()
   ```

7. **_Separators_** - Separators 可以在任意其他元素，之前，之间，之后添加。  `---`.

   ```markdown
   # My Part Title

   [A Prefix Chapter](relative/path/to/markdown.md)

   ---

   - [First Chapter](relative/path/to/markdown2.md)
   ```

### Example

下面是指南的 `SUMMARY.md`，渲染结果正是这本书左边的内容。

```markdown
{{#include ../SUMMARY.md}}
```
