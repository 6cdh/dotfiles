# Editor
export EDITOR=nvim

# BAT
export BAT_THEME="OneHalfLight"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --smart-case'
export FZF_DEFAULT_OPTS='-m --height 50% --border'

# Kitty Chinese
export GLFW_IM_MODULE=ibus

# speedup zsh autosuggestion
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

export PATH="/home/lcdh/.local/bin:$PATH"
export PATH="/home/lcdh/.local/share/coursier/bin:$PATH"

# override old SHELL=bash that inherits from host
export SHELL=zsh

# solve gpg error: Inappropriate ioctl for device
export GPG_TTY=$(tty)

