# Cargo
source "$HOME/.cargo/env"

# Go
export PATH="${PATH}:${HOME}/go/bin"

# Android
export ANDROID_HOME=${HOME}/Android/Sdk

# User-widen npm
export npm_config_prefix=~/.node_modules
export PATH="${HOME}/.node_modules/bin:${PATH}"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

# Chrome
export CHROME_EXECUTABLE="google-chrome-stable"

# Ruby
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="${PATH}:${GEM_HOME}/bin"

# Haskell
source ~/.ghcup/env

# Editor
export EDITOR=nvim

# Clang
export CC=/usr/bin/clang
export HOSTCC=/usr/bin/clang
export CXX=/usr/bin/clang++
export HOSTCXX=/usr/bin/clang++
export MAKEFLAGS=8

# CUDA
# export PATH="$PATH:/opt/cuda/bin"

# BAT
export BAT_THEME="TwoDark"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --smart-case'
export FZF_DEFAULT_OPTS='-m --height 50% --border'

# Kitty Chinese
export GLFW_IM_MODULE=ibus

