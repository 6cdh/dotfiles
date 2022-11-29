{ config, pkgs, ... }:

let pkgsUnstable = import <nixpkgs-unstable> { };
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
    delta
    git
    git-quick-stats
    imagemagick
    ranger
    python310Packages.compiledb
    tree-sitter
    ipfs
    fontforge
    youtube-dl
    cmake
    difftastic
    starship
    patchelf
    ipfs-cluster
    # info
    neofetch
    inxi
    tldr
    # lang
    racket
    guile
    sbcl
    chez
    ghc
    yarn
    opam
    ocaml
    rustup
    python3Minimal
    poetry
    nodejs
    nodePackages.prettier
    efm-langserver
    # lsp
    rnix-lsp
  ];
}
