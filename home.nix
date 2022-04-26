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
  home.stateVersion = "22.05";

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
    git-quick-stats
    # info
    neofetch
    inxi
    tldr
    # edit
    neovim
    emacs
    # dev
    proxychains-ng
    nix-prefetch
    # lang
    clang_13
    racket
    sbcl
    chez
    clojure
    leiningen
    yarn
    rustup
    python3Minimal
    go
    julia-bin
    ghc
    nodejs nodePackages.prettier
  ];

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "colored-man-pages"
          "extract"
          "fd"
          "git"
          "ripgrep"
          "rust"
          "vi-mode"
          "zoxide"
          "fzf"
        ];
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma-continuum";
            repo = "fast-syntax-highlighting";
            rev = "585c089";
            sha256 = "1lc9mhi25ybkcn0747j3i8y2hrmakv5mxndglf6yfiipxpd05vn7";
          };
        }
      ];
      shellAliases = {
        hm = "home-manager";
        ls = "exa";
        l = "ls -l";
        ll = "ls -la";
        la = "ls -la";
        vi = "nvim";
        py = "python3";
        cl = "clang++";
        free = "free -h";
        du = "du -h";
        df = "df -h";
        diff = "diff --color=always";
        rlwrap = "rlwrap -pgreen";
        gcl1 = "git clone --depth 1";
        nix-shell = "nix-shell --run zsh";
      };
      history = {
        save = 1000000;
        size = 1000000;
      };
      sessionVariables = {
        EDITOR = "nvim";
        BAT_THEME = "TwoDark";
        FZF_DEFAULT_COMMAND = "rg --files --smart-case";
        FZF_DEFAULT_OPTS = "-m --height 50% --border";
        LISP = "sbcl";
      };
      localVariables = {
        VI_MODE_SET_CURSOR = true;
        ZSH_AUTOSUGGEST_MANUAL_REBIND = true;
      };
      initExtra = (builtins.readFile ./shell/zsh/.zshcfg/.zsh_func.sh);
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  xdg = {
    configFile = {
      "nvim".source = ./editor/nvim;
      "nvim".recursive = true;
      "kitty/kitty.conf".source = ./terminal/kitty.conf;
      "starship.toml".source = ./shell/starship.toml;
      "efm-langserver/config.yaml".source = ./editor/efm.yaml;
      "fontconfig/conf.d/20-prefer.conf".source = ./gui/fonts.conf;
    };
    dataFile = {
      "fonts".source = ./gui/fonts;
    };
  };

  home.file.".profile".text = ''xrandr --newmode "2560x1440R" 241.50 2560 2608 2640 2720 1440 1443 1448 1481 +hsync +vsync
xrandr --addmode HDMI-1 2560x1440R
  '';

  fonts.fontconfig = {
    enable = true;
  };

  home.sessionVariables = {
    GLFW_IM_MODULE = "ibus";
  };
}
