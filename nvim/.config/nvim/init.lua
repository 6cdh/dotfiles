local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local indent = 4

g.mapleader = ' '

-- Plugins

-- packer.nvim
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_path)) > 0 then
    cmd([[!git clone https://github.com/wbthomason/packer.nvim --depth 1]] ..
            packer_path)
    cmd([[packadd packer.nvim]])
end

packer = require('packer')

packer.startup(function()
    use 'wbthomason/packer.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'

    use 'hrsh7th/nvim-compe'
    use {
        'tzachar/compe-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-compe'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use 'sbdchd/neoformat'

    use 'joshdick/onedark.vim'
end)

-- General Conf

local opts = {global = vim.o, buffer = vim.bo, window = vim.wo}

opts.window.number = true
opts.window.relativenumber = true

opts.global.textwidth = 90

opts.global.expandtab = true
opts.global.tabstop = indent
opts.global.shiftwidth = indent
opts.global.softtabstop = indent
opts.global.smartindent = true

opts.global.smartcase = true
opts.global.ignorecase = true

opts.global.completeopt = 'menuone,noselect'

opts.global.termguicolors = true
cmd [[colorscheme onedark]]

cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-- Keymaps

local mapmode = {
    normal = 'n',
    select = 's',
    visual = 'x',
    insert = 'i',
    cmd = 'c',
    terminal = 't',
    operator_pending = 'o',
    insert_cmd = '!',
    insert_cmd_langarg = 'l',
    visual_select = 'v'
}

-- map options example
local mapoptions = {noremap = true}

local keymap = vim.api.nvim_set_keymap

keymap(mapmode.normal, '<leader>w', ':w<CR>', {noremap = true})
keymap(mapmode.normal, '<leader>q', ':q<CR>', {noremap = true})
keymap(mapmode.normal, '<leader>Q', ':q!<CR>', {noremap = true})
keymap(mapmode.normal, '<C-j>', '<C-w>j', {noremap = true})
keymap(mapmode.normal, '<C-k>', '<C-w>k', {noremap = true})
keymap(mapmode.normal, '<C-h>', '<C-w>h', {noremap = true})
keymap(mapmode.normal, '<C-l>', '<C-w>l', {noremap = true})
keymap(mapmode.terminal, '<C-j>', [[<C-\><C-n><C-w>j]], {noremap = true})
keymap(mapmode.terminal, '<C-k>', [[<C-\><C-n><C-w>k]], {noremap = true})
keymap(mapmode.terminal, '<C-h>', [[<C-\><C-n><C-w>h]], {noremap = true})
keymap(mapmode.terminal, '<C-l>', [[<C-\><C-n><C-w>l]], {noremap = true})

keymap(mapmode.normal, '<leader>f', ':Neoformat<CR>', {noremap = true})
keymap(mapmode.visual, '<leader>f', ':Neoformat<CR>', {noremap = true})

-- lspconfig
require'lspconfig'.clangd.setup {}
require'lspconfig'.pyright.setup {}

-- treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c', 'cpp', 'json', 'lua', 'toml', 'haskell', 'javascript', 'latex',
        'python', 'go', 'css', 'html', 'bash'
    },
    highlight = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {enable = true}
}

-- compe
require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        tabnine = true
    }
}

-- neoformat
g.neoformat_basic_format_align = 1
g.neoformat_basic_format_retab = 1
g.neoformat_basic_format_trim = 1

g.neoformat_enabled_python = {'black'}
g.neoformat_enabled_haskell = {'ormolu'}

g.shfmt_opt = '-ci'

g.neoformat_enabled_toml = {'prettier'}
g.neoformat_toml_prettier = {
    exe = 'prettier',
    args = {'--stdin-filepath', '"%:p"'},
    stdin = 1
}

g.neoformat_enabled_make = {'makefmt'}
g.neoformat_make_makefmt = {exe = 'unexpand', args = {'-t 2'}, stdin = 1}

-- galaxyline
local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section

local gl_rainbow = function()
    -- auto change color according the vim mode
    local mode_color = {
        n = colors.green,
        i = colors.red,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red
    }
    cmd('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' ..
            colors.bg)
    return '▊ '
end

gl.short_line_list = {'nvimTree', 'packer'}

gls.left = {
    {ViMode = {provider = gl_rainbow}}, {
        FileSize = {
            provider = 'FileSize',
            condition = condition.buffer_not_empty,
            highlight = {colors.fg, colors.bg}
        }
    }, {
        FileIcon = {
            provider = 'FileIcon',
            condition = condition.buffer_not_empty,
            highlight = {
                require('galaxyline.provider_fileinfo').get_file_icon_color,
                colors.bg
            }
        }
    }, {
        FileName = {
            provider = 'FileName',
            condition = condition.buffer_not_empty,
            highlight = {colors.fg, colors.bg, 'bold'}
        }
    }, {
        LineInfo = {
            provider = 'LineColumn',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.fg, colors.bg}
        }
    }, {
        PerCent = {
            provider = 'LinePercent',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.fg, colors.bg, 'bold'}
        }
    }, {
        DiagnosticError = {
            provider = 'DiagnosticError',
            icon = '  ',
            highlight = {colors.red, colors.bg}
        }
    }, {
        DiagnosticWarn = {
            provider = 'DiagnosticWarn',
            icon = '  ',
            highlight = {colors.yellow, colors.bg}
        }
    }, {
        DiagnosticHint = {
            provider = 'DiagnosticHint',
            icon = '  ',
            highlight = {colors.cyan, colors.bg}
        }
    }, {
        DiagnosticInfo = {
            provider = 'DiagnosticInfo',
            icon = '  ',
            highlight = {colors.blue, colors.bg}
        }
    }
}

gls.mid = {
    {
        ShowLspClient = {
            provider = 'GetLspClient',
            condition = function()
                local tbl = {['dashboard'] = true, [''] = true}
                if tbl[vim.bo.filetype] then return false end
                return true
            end,
            icon = ' LSP: ',
            highlight = {colors.yellow, colors.bg, 'bold'}
        }
    }
}

gls.right = {
    {
        FileEncode = {
            provider = 'FileEncode',
            condition = condition.hide_in_width,
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.green, colors.bg, 'bold'}
        }
    }, {
        FileFormat = {
            provider = 'FileFormat',
            condition = condition.hide_in_width,
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.green, colors.bg, 'bold'}
        }
    }, {
        GitIcon = {
            provider = function() return '  ' end,
            condition = condition.check_git_workspace,
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.violet, colors.bg, 'bold'}
        }
    }, {
        GitBranch = {
            provider = 'GitBranch',
            condition = condition.check_git_workspace,
            highlight = {colors.violet, colors.bg, 'bold'}
        }
    }, {
        DiffAdd = {
            provider = 'DiffAdd',
            condition = condition.hide_in_width,
            icon = '  ',
            highlight = {colors.green, colors.bg}
        }
    }, {
        DiffModified = {
            provider = 'DiffModified',
            condition = condition.hide_in_width,
            icon = ' 柳',
            highlight = {colors.orange, colors.bg}
        }
    }, {
        DiffRemove = {
            provider = 'DiffRemove',
            condition = condition.hide_in_width,
            icon = '  ',
            highlight = {colors.red, colors.bg}
        }
    }, {ViMode = {provider = gl_rainbow}}
}

gls.short_line_left = {
    {
        BufferType = {
            provider = 'FileTypeName',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.blue, colors.bg, 'bold'}
        }
    }, {
        SFileName = {
            provider = 'SFileName',
            condition = condition.buffer_not_empty,
            highlight = {colors.fg, colors.bg, 'bold'}
        }
    }
}

gls.short_line_right = {
    {BufferIcon = {provider = 'BufferIcon', highlight = {colors.fg, colors.bg}}}
}

