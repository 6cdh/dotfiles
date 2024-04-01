sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

yay -Syu visual-studio-code-bin \
    zsh neovim vim unzip bat exa fd ripgrep fzf zoxide htop \
    scc-bin cmus rclone rlwrap hyperfine github-cli imagemagick \
    difftastic starship android-tools \
    racket julia multon zig \
    tmux tree-sitter-cli valgrind wl-clipboard \
    neofetch npm proxychains-ng rsync rustup \
    llvm lsof clang emacs

# change shell
sudo chsh -s /bin/zsh lcdh

# use host xdg-open
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/xdg-open
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman-compose
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/flatpak
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/xdotool
