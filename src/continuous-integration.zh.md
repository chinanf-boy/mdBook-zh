# Running `mdbook` in Continuous Integration

虽然以下示例使用Travis CI,但他们的原则也应该直接转移到其他持续集成提供商.

## Ensuring Your Book Builds and Tests Pass

以下是Travis CI的示例`.travis.yml`确保配置`mdbook
build`和`mdbook test`运行成功.快速CI周转时间的关键是缓存`mdbook`安装,以便您不编译`mdbook`每次CI运行.

```yaml
language: rust
sudo: false

cache:
  - cargo

rust:
  - stable

before_script:
  - (test -x $HOME/.cargo/bin/cargo-install-update || cargo install cargo-update)
  - (test -x $HOME/.cargo/bin/mdbook || cargo install --vers "^0.1" mdbook)
  - cargo install-update -a

script:
  - mdbook build path/to/mybook && mdbook test path/to/mybook
```

## Deploying Your Book to GitHub Pages

遵循这些说明将导致在您的存储库成功运行CI后,您的图书将发布到GitHub页面`master`科.

首先,使用"public_repo"权限(或私有存储库的"repo")创建一个新的GitHub"个人访问令牌".转到存储库的Travis CI设置页面并添加一个名为的环境变量`GITHUB_TOKEN`这标志着安全和*不*显示在日志中.

然后,将此代码段附加到您的`.travis.yml`并更新到的路径`book`目录:

```yaml
deploy:
  provider: pages
  skip-cleanup: true
  github-token: $GITHUB_TOKEN
  local-dir: path/to/mybook/book
  keep-history: false
  on:
    branch: master
```

而已!
