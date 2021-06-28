# dotfiles

6cdh’s dotfiles.

## Install Linters, LSPs and Formatters

For me, linters and neovim work together.

You need to install [yq](https://github.com/mikefarah/yq) and run

``` shell
zsh <(yq e '.[].run' linters.yml)
```

Install only linters, LSPs and formatters for Python:

``` shell
zsh <(yq e '.[] | select(.lang | .[] == "python").run' linters.yml)
```

Install only linters for Python:

``` shell
zsh <(yq e '.[] | select((.lang | .[] == "python") and (.type | .[] == "linter")).run' linters.yml)
```

## Install dotfiles

I use [GNU stow](https://www.gnu.org/software/stow/) to manage my dotfiles.

``` bash
# Install nvim config
stow -t ~ nvim
# Install vim config
stow -t ~ vim
# Install zsh config
stow -t ~ zsh
# Install kitty config
stow -t ~ kitty
# Uninstall zsh config
stow -t ~ -D zsh
```

You may want to use `stow -nv -t ~ <DIR>` to see what stow will do before any
modifications.

## About Emacs

My emacs configuration is essentially a copy of Doom Emacs plus a little customization.
Its org-mode is really great.
