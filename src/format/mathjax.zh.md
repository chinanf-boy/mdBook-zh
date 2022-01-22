# MathJax 支持

mdBook，可以用[MathJax](https://www.mathjax.org/)，支持数学公式

要启用 MathJax，您需要在`book.toml`中的`output.html`部分添加`mathjax-support`。

```toml
[output.html]
mathjax-support = true
```

> **注意:** MathJax 使用的常用分隔符尚不支持。你目前无法使用`$$ ... $$`作为分隔符，且`\[ ... \]`分隔符需要额外的反斜杠才能工作。希望这个限制很快就会解除.
>
> **注意:** 在 MathJax 块中使用双反斜杠时(例如，在`\begin{cases} \frac 1 2 \\ \frac 3 4 \end{cases}`之类的命令中)你需要添加*另外两个*反斜杠(如，`\begin{cases} \frac 1 2 \\\\ \frac 3 4 \end{cases}`).

### 内联方程

内联方程由`\\(`和`\\)`分隔。例如，渲染以下内联方程 \\( \int x dx = \frac{x^2}{2} + C \\)，你要写下面的内容:

```
\\( \int x dx = \frac{x^2}{2} + C \\)
```

### 块方程

块方程由`\\[`和`\\]`分隔.要渲染以下等式

\\[ \mu = \frac{1}{N} \sum_{i=0} x_i \\]

你会写:

```bash
\\[ \mu = \frac{1}{N} \sum_{i=0} x_i \\]
```
