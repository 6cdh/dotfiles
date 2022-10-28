{ config, pkgs, ... }:

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
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";

  home.packages = with pkgs; [
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
    # info
    neofetch
    inxi
    tldr
    # edit
    vim
    neovim
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

  xdg = {
    configFile = {
      "kitty/kitty.conf".source = ./terminal/kitty.conf;
      "starship.toml".source = ./shell/starship.toml;
      "efm-langserver/config.yaml".source = ./editor/efm.yaml;
      "fontconfig/conf.d/20-prefer.conf".source = ./gui/fonts.conf;
      "alacritty/alacritty.yml".source = ./terminal/alacritty.yml;
    };
    dataFile = {
      "fonts".source = ./gui/fonts;
    };
  };

  fonts.fontconfig = {
    enable = true;
  };
}
