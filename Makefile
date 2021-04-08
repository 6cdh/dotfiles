PWD = $(shell pwd)

ZSH_CONF = ${PWD}/zsh
VIM_CONF = ${PWD}/vim
NVIM_CONF = ${PWD}/nvim
TERM_CONF = ${PWD}/terminal

HOME := $(HOME)
NVIM_PATH = ${HOME}/.config/nvim
KITTY_PATH = ${HOME}/.config/kitty
VIM_PATH = ${HOME}/.vim

all: install

.PHONY: install vim nvim terminal pam_env zsh gitconfig

install: zsh gitconfig vim

vim:
	ln -s ${VIM_CONF}/.vimrc ${HOME}/.vimrc
	ln -s ${NVIM_CONF}/coc-settings.json ${VIM_PATH}/coc-settings.json

nvim:
	ln -s ${NVIM_CONF}/init.vim ${NVIM_PATH}/init.vim
	ln -s ${NVIM_CONF}/coc-settings.json ${NVIM_PATH}/coc-settings.json

terminal:
	ln -s ${TERM_CONF}/kitty.conf ${KITTY_PATH}/kitty.conf

pam_env:
	ln -s ${PWD}/.pam_environment ${HOME}/.pam_environment

zsh:
	ln -s ${ZSH_CONF}/.zshrc ${HOME}/.zshrc
	ln -s ${ZSH_CONF}/.zshenv ${HOME}/.zshenv
	ln -s ${ZSH_CONF}/.zshfunc.sh ${HOME}/.zshfunc.sh

gitconfig:
	ln -s ${PWD}/.gitconfig ${HOME}/.gitconfig
