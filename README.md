# dotfiles

6cdh's dotfiles.

## Install Linters, LSPs and Formatters

For me, linters and neovim work together.

You need to install [yq](https://github.com/mikefarah/yq) and run

```shell
zsh <(yq -r '.[].run' < linters.yml)
```

Install only linters, LSPs and formatters for Python:

```
zsh <(yq -r '.[] | select(.lang | .[] == "python").run' < linters.yml)
```

Install only linters for Python:

```
zsh <(yq -r '.[] | select((.lang | .[] == "python") and (.type | .[] == "linter")).run' < linters.yml)
```

