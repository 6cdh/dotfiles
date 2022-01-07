# dotfiles

6cdh’s dotfiles.

These configs are not optimized for installing by others but can be a reference.

I use [Colemak](https://en.wikipedia.org/wiki/Colemak) keyboard layout, so the keymaps
should optimized for it.

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

## Install Linters, LSPs and Formatters

For me, linters, [efm-lang server](https://github.com/mattn/efm-langserver) and neovim
work together.

The config of linters is in [linters.yml](linters.yml)

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

## Nvim

Nvim config is mostly written in Fennel. Thanks
[hotpot.nvim](https://github.com/rktjmp/hotpot.nvim) :)

Some config:

-   [statusline.fnl](nvim/.config/nvim/fnl/statusline.fnl) -
    statusline([feline.nvim](https://github.com/famiu/feline.nvim))
-   [lsp.fnl](nvim/.config/nvim/fnl/lsp.fnl) -
    [lspconfig](https://github.com/neovim/nvim-lspconfig)
-   [options.fnl](nvim/.config/nvim/fnl/options.fnl) - vim/nvim builtin options
-   [complete.fnl](nvim/.config/nvim/fnl/complete.fnl) -
    complete([nvim-cmp](https://github.com/hrsh7th/nvim-cmp))
-   [keymap.fnl](nvim/.config/nvim/fnl/keymap.fnl) - key mappings
-   [register.fnl](nvim/.config/nvim/fnl/register.fnl) - utilities to define command with
    fennel
-   [plugins.fnl](nvim/.config/nvim/fnl/plugins.fnl) - plugins list

> A short word for why fennel/lisp?
>
> Because why not? You will never look back once you try it.

## Vim

The config of vim is in [archive/vim](archive/vim) and is not maintained.

## Emacs

~~My emacs configuration is essentially a copy of Doom Emacs plus a little customization.
Its org-mode is really great.~~

I no longer use Emacs. Instead, I use mediawiki to manage my knowledge base.
