# MathJax Support

mdBook通过可选的数学方程式支持[MathJax](https://www.mathjax.org/).

要启用MathJax,您需要添加`mathjax-support`你的关键`book.toml`在下面`output.html`部分.

```toml
[output.html]
mathjax-support = true
```

> **注意:**MathJax使用的常用分隔符尚不支持.你目前无法使用`$$ ... $$`作为分隔符和`\[ ... \]`分隔符需要额外的反斜杠才能工作.希望这个限制很快就会解除.
>
> **注意:**在MathJax块中使用双反斜杠时(例如在诸如.之类的命令中)`\begin{cases} \frac 1 2 \\ \frac 3 4 \end{cases}`)你需要添加*另外两个*反斜杠(例如,`\begin{cases} \frac 1 2 \\\\ \frac 3 4
> \end{cases}`).

### Inline equations

内联方程由以下分隔`\\(`和`\\)`.例如,渲染以下内联方程\\(\\ int x dx = \\ frac {x ^ 2} {2} + C.\\)你会写下面的内容:

```
\\( \int x dx = \frac{x^2}{2} + C \\)
```

### Block equations

块方程由以下分隔`\\[`和`\\]`.要呈现以下等式

\\[\ mu = \ frac {1}{ }N\ _{ sum= }i _ 0\\ xi]

你会写:

```bash
\\[ \mu = \frac{1}{N} \sum_{i=0} x_i \\]
```
