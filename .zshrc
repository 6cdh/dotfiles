# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='powerlevel10k/powerlevel10k'
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_CUSTOM_USER='echo 6cdh'
POWERLEVEL9K_CUSTOM_USER_BACKGROUND='black'
POWERLEVEL9K_CUSTOM_USER_FOREGROUND='skyblue1'

POWERLEVEL9K_DIR_BACKGROUND='skyblue1'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=''
POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_first_and_last'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump
    colorize
    colored-man-pages
    extract
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch native"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Environments
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
# export PATH="$PATH:/opt/cuda/bin"
export ANDROID_HOME=${HOME}/Android/Sdk

export PROXY_ADDR="127.0.0.1:4097"
export PROXY_ENV="http_proxy=http://${PROXY_ADDR} https_proxy=http://${PROXY_ADDR} no_proxy=localhost,127.0.0.1"
export MAKEFLAGS=8

#export CHROME_EXECUTABLE="google-chrome-stable"

# user-widen npm
export PATH="${HOME}/.node_modules/bin:${PATH}"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

# ruby
export PATH="${HOME}/.gem/ruby/2.7.0/bin:${PATH}"

# haskell
export PATH="${HOME}/.ghcup/bin:${PATH}"

# npm global path
export npm_config_prefix=~/.node_modules

# editor
export EDITOR=nvim

# clang
export CC=/usr/bin/clang
export HOSTCC=/usr/bin/clang
export CXX=/usr/bin/clang++
export HOSTCXX=/usr/bin/clang++

# config
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# package manager
# alias pip="${PROXY_ENV} pip"
alias pub="${PROXY_ENV} pub"
alias cargo="${PROXY_ENV} cargo"
alias npm="${PROXY_ENV} npm"
alias yarn="${PROXY_ENV} yarn"

# programming
alias py="python3"
alias supy="sudo python3"
alias go="${PROXY_ENV} go"
alias cl="clang++"

# application
alias spp="sudo proxychains4"
alias pp="proxychains4"

# common
alias free="free -h"
alias du="du -h"
alias df="df -h"
alias vi="${PROXY_ENV} nvim"
alias suvi="${PROXY_ENV} sudo nvim"
alias ll="ls -l"
alias diff="diff --color=always"
alias googler="${PROXY_ENV} googler"
alias how2="${PROXY_ENV} how2"

eval "$(pyenv init -)"

# function
source ~/.zshfunc.sh

fpath+=~/.zfunc

compinit -d

