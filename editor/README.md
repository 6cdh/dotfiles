## Install Linters, LSPs and Formatters

For me, linters, [efm-lang server](https://github.com/mattn/efm-langserver) and neovim
work together.

The config of linters is in [editor/linters.yml](./linters.yml)

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

-   [statusline.fnl](nvim/fnl/statusline.fnl) -
    statusline([feline.nvim](https://github.com/famiu/feline.nvim))
-   [lsp.fnl](nvim/fnl/lsp.fnl) -
    [lspconfig](https://github.com/neovim/nvim-lspconfig)
-   [options.fnl](nvim/fnl/options.fnl) - vim/nvim builtin options
-   [complete.fnl](nvim/fnl/complete.fnl) -
    complete([nvim-cmp](https://github.com/hrsh7th/nvim-cmp))
-   [keymap.fnl](nvim/fnl/keymap.fnl) - key mappings
-   [register.fnl](nvim/fnl/register.fnl) - utilities to define
    command with fennel
-   [plugins.fnl](nvim/fnl/plugins.fnl) - plugins list

> A short word for why fennel/lisp?
>
> Because why not? You will never look back once you try it.
