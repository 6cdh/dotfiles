vim.g.mapleader = ' '

local cmd = vim.cmd
local fn = vim.fn
local nvim_cmd = vim.api.nvim_command
local g = vim.g

local indent = 4

cmd [[packadd packer.nvim]]

packer = require('packer')

packer.startup(function()
    use 'wbthomason/packer.nvim'

    use 'joshdick/onedark.vim'
end)

cmd [[syntax on]]
cmd [[filetype plugin indent on]]

