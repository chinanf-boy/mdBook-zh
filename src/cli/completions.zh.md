# The completions command

completions 用于自动补全命令。
这意味着，当你在终端上，输入 `mdbook`, 你可以按下补全键 (通常是 Tab) ，就会补全你的命令。

当然，要先安装下：

```bash
mdbook completions bash > ~/.local/share/bash-completion/completions/mdbook
```

这个命令会打印补全脚本。
运行 `mdbook completions --help` 看看所支持的。
