# dotfiles

6cdh's dotfiles.

## Install Linters, LSPs and Formatters

For me, linters and neovim work together.

You need to install [yq](https://github.com/mikefarah/yq) and run

```shell
zsh <(yq e '.[].run' linters.yml)
```

Install only linters, LSPs and formatters for Python:

```
zsh <(yq e '.[] | select(.lang | .[] == "python").run' linters.yml)
```

Install only linters for Python:

```
zsh <(yq e '.[] | select((.lang | .[] == "python") and (.type | .[] == "linter")).run' linters.yml)
```

## Install dotfiles

```bash
# Install nvim config
make nvim
# Install vim config
make vim
# Install zsh config
make zsh
# Install kitty config
make terminal
```
