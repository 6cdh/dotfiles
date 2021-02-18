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
export PATH="${HOME}/.gem/ruby/2.7.0/bin:${PATH}"

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
