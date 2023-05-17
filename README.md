# Dotfiles

6cdh's dotfiles.

These configs are not optimized for installing by others but can be a reference.

## Info

```yaml
system: fedora linux
package manager: [dnf, nix]
keyboard layout: [colemak, us(chinese)]
editor: [vscode, neovim, emacs]
terminal: kitty
```

## Manage

I have a racket script [init.rkt](init.rkt) that link data and config, backup data to cloud, install necessary packages. Like this:

```shell
racket init.rkt link
racket init.rkt backup
racket init.rkt pkg
```

