(user 'lcdh)

(soft-link (xdg/config "nvim") => "./editor/nvim"
           (xdg/config "emacs") => "./editor/emacs"
           (home ".zshcfg") => "./shell/zsh/.zshcfg/"
           (home ".zshrc") => "./shell/zsh/.zshrc"
           (home ".gitconfig") => "./git/.gitconfig")
