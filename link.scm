(user 'lcdh)

(soft-link (xdg/config "nvim") => "./editor/nvim"
           (xdg/config "emacs") => "./editor/emacs"
           (home ".zshcfg") => "./shell/zsh/.zshcfg/"
           (home ".gitconfig") => "./git/.gitconfig")
