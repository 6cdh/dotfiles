local colors = require 'theme.colors'
local icons = require 'theme.icons'
local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

-- Meta Data

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    REPLACE = colors.red,
    VISUAL = colors.magenta,
    COMMAND = colors.blue,
    TERM = colors.darkblue,
    NONE = colors.yellow,
}

-- Funcs

local function wrapper_str(msg, s)
    return s .. msg .. s
end

local function file_osinfo()
    local os = vim.bo.fileformat:lower()
    return icons[os] .. os
end

local function lsp_clientnames()
    local icon = icons.lsp
    local clients = {}
    for _, client in pairs(vim.lsp.buf_get_clients()) do
        clients[#clients + 1] = client.name
    end

    if #clients == 0 then
        return ''
    end

    return icon .. table.concat(clients, '/')
end

local function lsp_diagnostics_info()
    return {
        errs = lsp.get_diagnostics_count 'Error',
        warns = lsp.get_diagnostics_count 'Warning',
        infos = lsp.get_diagnostics_count 'Information',
        hints = lsp.get_diagnostics_count 'Hint',
    }
end

local function diag_enable(f, s)
    return function()
        local diag = f()[s]
        return diag and diag ~= 0
    end
end

local function diag_of(f, s)
    local icon = icons[s]
    return function()
        local diag = f()[s]
        return icon .. diag
    end
end

local function vimode_hl()
    return { fg = colors.bg, bg = vi_mode_utils.get_mode_color() }
end

-- LuaFormatter off

-- Layout

local comps = {
    vi_mode = {
        left = {
            provider = function()
                return wrapper_str(vi_mode_utils.get_vim_mode():sub(1, 3), ' ')
            end,
            hl = vimode_hl,
            right_sep = icons.right_sep,
        },
        right = {
            provider = function()
                return string.format(' %d:%-d ', vim.fn.line '.', vim.fn.col '.')
            end,
            hl = vimode_hl,
            left_sep = icons.left_sep,
        },
    },
    file = {
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold',
            },
        },
        info = {
            provider = 'file_info',
            hl = {
                fg = colors.blue,
                style = 'bold',
            },
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold',
            },
        },
        type = {
            provider = 'file_type',
        },
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold',
        },
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = function()
            return {
                fg = vi_mode_utils.get_mode_color(),
            }
        end,
    },
    diagnos = {
        err = {
            provider = diag_of(lsp_diagnostics_info, 'errs'),
            left_sep = ' ',
            enabled = diag_enable(lsp_diagnostics_info, 'errs'),
            hl = {
                fg = colors.red,
            },
        },
        hint = {
            provider = diag_of(lsp_diagnostics_info, 'hints'),
            left_sep = ' ',
            enabled = diag_enable(lsp_diagnostics_info, 'hints'),
            hl = {
                fg = colors.cyan,
            },
        },
        info = {
            provider = diag_of(lsp_diagnostics_info, 'infos'),
            left_sep = ' ',
            enabled = diag_enable(lsp_diagnostics_info, 'infos'),
            hl = {
                fg = colors.blue,
            },
        },
        warn = {
            provider = diag_of(lsp_diagnostics_info, 'warns'),
            left_sep = ' ',
            enabled = diag_enable(lsp_diagnostics_info, 'warns'),
            hl = {
                fg = colors.yellow,
            },
        },
    },
    git = {
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green,
            },
        },
        branch = {
            provider = 'git_branch',
            icon = icons.git,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold',
            },
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange,
            },
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red,
            },
        },
    },
    lsp = {
        name = {
            provider = lsp_clientnames,
            icon = icons.lsp,
            enabled = function()
                return lsp_clientnames() ~= ''
            end,
            hl = {
                fg = colors.yellow,
            },
        },
    },
    space = {
        provider = ' ',
    },
}

local properties = {
    force_inactive = {
        filetypes = {
            'NvimTree',
            'dbui',
            'packer',
            'startify',
            'fugitive',
            'fugitiveblame',
        },
        buftypes = { 'terminal' },
        bufnames = {},
    },
}

local components = {
    left = {
        active = {
            comps.vi_mode.left,
            comps.space,
            comps.file.info,
            comps.lsp.name,
            comps.diagnos.err,
            comps.diagnos.warn,
            comps.diagnos.hint,
            comps.diagnos.info,
        },
        inactive = {
            comps.vi_mode.left,
            comps.space,
            comps.file.info,
        },
    },
    mid = {
        active = {},
        inactive = {},
    },
    right = {
        active = {
            comps.git.add,
            comps.git.change,
            comps.git.remove,
            comps.file.os,
            comps.git.branch,
            comps.line_percentage,
            comps.space,
            comps.vi_mode.right,
        },
        inactive = {},
    },
}

-- LuaFormatter on

require('feline').setup {
    default_bg = colors.bg,
    default_fg = colors.fg,
    components = components,
    properties = properties,
    vi_mode_colors = vi_mode_colors,
}
