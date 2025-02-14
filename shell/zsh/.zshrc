### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

source ~/.zshcfg/.zsh_func.sh
source ~/.zshcfg/.zsh_aliases.sh
source ~/.zshcfg/.zshenv

autoload -U compinit
compinit

zinit light zdharma-continuum/fast-syntax-highlighting
zinit snippet OMZP::extract
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::git
zinit snippet OMZP::zoxide
zinit snippet OMZP::fzf

zinit ice blockf
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# theme
zinit ice depth=1
zinit light romkatv/powerlevel10k
source ~/.zshcfg/.p10k.zsh

# History size
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt nomatch notify histignoredups
unsetopt autocd beep

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line

lctoolset_clang

# Auto Rehash
zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pnpm
export PNPM_HOME="/var/home/lcdh/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

