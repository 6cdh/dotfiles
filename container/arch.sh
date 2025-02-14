sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

yay -Syu visual-studio-code-bin \
    zsh neovim vim unzip bat eza fd ripgrep fzf zoxide htop \
    scc-bin cmus rclone rlwrap hyperfine github-cli imagemagick \
    difftastic starship android-tools \
    racket julia multon zig sbcl \
    tmux tree-sitter-cli valgrind wl-clipboard \
    neofetch npm proxychains-ng rsync rustup \
    llvm lsof clang emacs

# change shell
sudo chsh -s /bin/zsh lcdh
