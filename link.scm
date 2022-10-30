(user 'lcdh)

(soft-link (xdg/config "nvim") => "./editor/nvim"
           (xdg/config "emacs") => "./editor/emacs"
           (home ".zshcfg") => "./shell/zsh/.zshcfg/"
           (home ".zshrc") => "./shell/zsh/.zshrc"
           (xdg/config "kitty") => "./terminal/kitty"
           (xdg/config "starship.toml") => "./shell/starship.toml"
           (xdg/config "efm-langserver") => "./editor/efm-langserver"
           (xdg/config "alacritty") => "./terminal/alacritty"
           (xdg/data "fonts") => "./gui/fonts"
           (home ".gitconfig") => "./git/.gitconfig")
