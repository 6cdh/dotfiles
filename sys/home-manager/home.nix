{ config, pkgs, ... }:

let pkgsUnstable = import <nixpkgs> { };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lcdh";
  home.homeDirectory = "/home/lcdh";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";

  home.packages = with pkgsUnstable; [
    # shell
    neovim
    bat
    exa
    fd
    ripgrep
    fzf
    htop
    geoipWithDatabase
    scc
    cmus
    rclone
    zoxide
    rlwrap
    hyperfine
    git
    gh
    imagemagick
    fontforge
    difftastic
    starship
    patchelf
    android-tools
    # info
    tldr
    # lang
    guile_3_0
    julia-bin
    racket
    sbcl
    roswell
    chez
    ghc
    yarn
    rustup
    python3Minimal
    poetry
    nodejs
    nodePackages.prettier
  ];
}
