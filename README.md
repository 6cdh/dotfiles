# dotfiles

6cdh’s dotfiles.

These configs are not optimized for installing by others but can be a reference.

## Info

``` shell
System: Arch Linux
Keyboard Layout: Colemak
Editor: neovim
Terminal: kitty
```

## Install

I use a [Guile Scheme](https://www.gnu.org/software/guile/) script [home.scm](./home.scm)
to manage my config.

Make sure you have guile installed, then run

``` bash
./script/eval.scm home.scm
```

The file `eval.scm` contains the environment interpreting the config `home.scm`.
