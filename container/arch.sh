sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

yay -Syu google-chrome keepassxc visual-studio-code \
    zsh neovim bat exa fd ripgrep fzf zoxide \
    scc-bin cmus rclone rlwrap hyperfine github-cli imagemagick \
    difftastic starship android-tools \
    racket julia

sudo chsh -s /bin/zsh lcdh
