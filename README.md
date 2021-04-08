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

I use [GNU stow](https://www.gnu.org/software/stow/) to manage my dotfiles.

```bash
# Install nvim config
stow -t ~ -D nvim
# Install vim config
stow -t ~ -D vim
# Install zsh config
stow -t ~ -D zsh
# Install kitty config
stow -t ~ -D kitty
```

You may want to use `stow -nv -t ~ -D <DIR>` to see what stow will do before any modifications.
