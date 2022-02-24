;; user config ;;

(user 'lcdh)
#(system 'archlinux)

(soft-link (xdg/config "fontconfig/fonts.conf") => "./gui/fonts.conf"
           (xdg/data   "fonts")                => "./gui/fonts"
           (home ".zshrc")                      => "./shell/zsh/.zshrc"
           (home ".zshenv")                     => "./shell/zsh/.zshenv"
           (home ".zshcfg")                     => "./shell/zsh/.zshcfg"
           (xdg/config "starship.toml")         => "./shell/starship.toml"
           (home ".pam_environment")            => "./shell/.pam_environment"
           (xdg/config "nvim")                  => "./editor/nvim"
           (xdg/config "kitty/kitty.conf")                 => "./terminal/kitty.conf"
           (xdg/config "efm-langserver/config.yaml") => "./editor/efm.yaml")

(define (zsh-plugin path)
  (home ".oh-my-zsh/custom/plugins/" path))

(fetch-github ("ohmyzsh/ohmyzsh"
                => (home ".oh-my-zsh") 'quiet)
              ("zdharma-continuum/fast-syntax-highlighting"
                => (zsh-plugin "fast-syntax-highlighting") 'quiet)
              ("zsh-users/zsh-autosuggestions"
                => (zsh-plugin "zsh-autosuggestions") 'quiet))

(ensure-install
 ('yay exa ripgrep bat zoxide fzf rlwrap fd
       neovim python-neovim xclip
       inxi
       cmus
       unzip unrar zip
       rclone
       grex
       ; nvidia
       dkms
       nvidia-dkms
       linux-lts-headers
       ; gui
       firefox
       keepassxc
       telegram-desktop
       fcitx5-im fcitx5-chinese-addons
       ; lang
       racket
       rustup
       clang
       ruby ruby-irb
       python-poetry
       julia
       ; lsp
       efm-langserver
       bash-language-server)
 ('raco '(racket-langserver)))

(service
  ('enable fstrim.timer))
