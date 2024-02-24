# Dotfiles

6cdh's dotfiles.

These configs are not optimized for installing by others but can be a reference.

## Info

```yaml
system: fedora linux
package manager: [rpm-ostree, yay]
keyboard layout: [colemak, us(chinese)]
editor: [vscode, neovim, emacs]
terminal: Warp
```

## Manage

I have a racket script [init.rkt](init.rkt) that link data and config, backup data to cloud. Like this:

```bash
racket init.rkt link
racket init.rkt backup
```

