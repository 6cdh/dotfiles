# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='powerlevel10k/powerlevel10k'

# ==========================
# P10k configuration
# ==========================

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
    emulate -L zsh -o extended_glob

    # Unset all configuration options.
    unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

    # Zsh >= 5.1 is required.
    autoload -Uz is-at-least && is-at-least 5.1 || return

    # Prompt colors.
    local grey='242'
    local red='#FF5C57'
    local yellow='#F3F99D'
    local blue='#57C7FF'
    local magenta='#FF6AC1'
    local cyan='#9AEDFE'
    local white='#F1F1F0'

    # Left prompt segments.
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    # context                 # user@host
    dir                       # current directory
    vcs                       # git status
    # command_execution_time  # previous command duration
    # =========================[ Line #2 ]=========================
    newline                   # \n
    # virtualenv              # python virtual environment
    prompt_char               # prompt symbol
    )

    # Right prompt segments.
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    command_execution_time    # previous command duration
    virtualenv                # python virtual environment
    context                   # user@host
    # time                    # current time
    # =========================[ Line #2 ]=========================
    newline                   # \n
    )

    # Basic style options that define the overall prompt look.
    typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
    typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

    # Add an empty line before each prompt except the first. This doesn't emulate the bug
    # in Pure that makes prompt drift down whenever you use the Alt-C binding from fzf or similar.
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

    # Magenta prompt symbol if the last command succeeded.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$magenta
    # Red prompt symbol if the last command failed.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$red
    # Default prompt symbol.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
    # Prompt symbol in command vi mode.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
    # Prompt symbol in visual vi mode is the same as in command mode.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='❮'
    # Prompt symbol in overwrite vi mode is the same as in command mode.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

    # Grey Python Virtual Environment.
    typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$grey
    # Don't show Python version.
    typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
    typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

    # Blue current directory.
    typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue

    # Context format when root: user@host. The first part white, the rest grey.
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%f%F{$grey}@%m%f"
    # Context format when not root: user@host. The whole thing grey.
    typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
    # Don't show context unless root or in SSH.
    typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

    # Show previous command duration only if it's >= 5s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
    # Don't show fractional seconds. Thus, 7s rather than 7.3s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
    # Duration format: 1d 2h 3m 4s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
    # Yellow previous command duration.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow

    # Grey Git prompt. This makes stale prompts indistinguishable from up-to-date ones.
    typeset -g POWERLEVEL9K_VCS_FOREGROUND=$grey

    # Disable async loading indicator to make directories that aren't Git repositories
    # indistinguishable from large Git repositories without known state.
    typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=

    # Don't wait for Git status even for a millisecond, so that prompt always updates
    # asynchronously when Git state changes.
    typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

    # Cyan ahead/behind arrows.
    typeset -g POWERLEVEL9K_VCS_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=$cyan
    # Don't show remote branch, current tag or stashes.
    typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)
    # Don't show the branch icon.
    typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
    # When in detached HEAD state, show @commit where branch normally goes.
    typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
    # Don't show staged, unstaged, untracked indicators.
    typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=
    # Show '*' when there are staged, unstaged or untracked files.
    typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
    # Show '⇣' if local branch is behind remote.
    typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=':⇣'
    # Show '⇡' if local branch is ahead of remote.
    typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=':⇡'
    # Don't show the number of commits next to the ahead/behind arrows.
    typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1
    # Remove space between '⇣' and '⇡' and all trailing spaces.
    typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${${${P9K_CONTENT/⇣* :⇡/⇣⇡}// }//:/ }'

    # Grey current time.
    typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
    # Format for the current time: 09:51:02. See `man 3 strftime`.
    typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
    # If set to true, time will update when you hit enter. This way prompts for the past
    # commands will contain the start times of their commands rather than the end times of
    # their preceding commands.
    typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

    # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
    # when accepting a command line. Supported values:
    #
    #   - off:      Don't change prompt when accepting a command line.
    #   - always:   Trim down prompt when accepting a command line.
    #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
    #               typed after changing current working directory.
    typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

    # Instant prompt mode.
    #
    #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
    #              it incompatible with your zsh configuration files.
    #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
    #              during zsh initialization. Choose this if you've read and understood
    #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
    #   - verbose: Enable instant prompt and print a warning when detecting console output during
    #              zsh initialization. Choose this if you've never tried instant prompt, haven't
    #              seen the warning, or if you are unsure what this all means.
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

    # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
    # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
    # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
    # really need it.
    typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

    # If p10k is already loaded, reload configuration.
    # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
    (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'


# POWERLEVEL9K_CUSTOM_USER='echo 6cdh'
# POWERLEVEL9K_CUSTOM_USER_BACKGROUND='black'
# POWERLEVEL9K_CUSTOM_USER_FOREGROUND='skyblue1'
#
# POWERLEVEL9K_DIR_BACKGROUND='skyblue1'
#
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_DELIMITER=''
# POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_first_and_last'
#
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_user dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time)

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
    z
    colorize
    colored-man-pages
    extract
    fzf
    zsh-autosuggestions
    fast-syntax-highlighting
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
export PATH="${HOME}/.cabal/bin:${HOME}/.ghcup/bin:${PATH}"

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

# History size
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

# function
source ~/.zshfunc.sh

