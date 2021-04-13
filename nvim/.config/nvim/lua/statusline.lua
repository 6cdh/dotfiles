local cmd = vim.cmd

-- galaxyline
local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
local glf = require('galaxyline.provider_fileinfo')
local lspclient = require('galaxyline.provider_lsp')

colors.bg = '#2c323c'
colors.fg = '#abb2bf'
colors.yellow = '#ECBE7B'
colors.cyan = '#008080'
colors.darkblue = '#081633'
colors.green = '#98be65'
colors.orange = '#FF8800'
colors.violet = '#a9a1e1'
colors.magenta = '#c678dd'
colors.blue = '#51afef'
colors.red = '#ec5f67'

local gl_rainbow = function()
    -- auto change color according the vim mode
    local mode_color = {
        n = colors.green,
        i = colors.blue,
        v = colors.magenta,
        [''] = colors.blue,
        V = colors.magenta,
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
    return '▊'
end

gl.short_line_list = {'nvimtree', 'packer'}

local file_size = function() return '' end

gls.left = {
    {ViMode = {provider = gl_rainbow}}, {
        FileSize = {
            provider = file_size,
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
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
        PerCent = {
            provider = 'LinePercent',
            highlight = {colors.fg, colors.bg, 'bold'}
        }
    }, {
        DiagnosticError = {
            provider = 'DiagnosticError',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            icon = ' ',
            highlight = {colors.red, colors.bg}
        }
    }, {
        DiagnosticWarn = {
            provider = 'DiagnosticWarn',
            icon = ' ',
            highlight = {colors.yellow, colors.bg}
        }
    }, {
        DiagnosticHint = {
            provider = 'DiagnosticHint',
            icon = ' ',
            highlight = {colors.cyan, colors.bg}
        }
    }, {
        DiagnosticInfo = {
            provider = 'DiagnosticInfo',
            icon = ' ',
            highlight = {colors.blue, colors.bg}
        }
    }
}

local lsp_info = function()
    local lsp_client = lspclient.get_lsp_client()
    return lsp_client == 'No Active Lsp' and '' or lsp_client
end

gls.mid = {
    {
        ShowLspClient = {
            provider = lsp_info,
            condition = function()
                local tbl = {['dashboard'] = true, [''] = true}
                if tbl[vim.bo.filetype] then return false end
                return true
            end,
            icon = '漣LSP: ',
            highlight = {colors.yellow, colors.bg, 'bold'}
        }
    }
}

local function file_encoding()
    local encoding = glf.get_file_encode()
    return encoding == ' UTF-8' and '' or encoding
end

gls.right = {
    {
        FileEncode = {
            provider = file_encoding,
            condition = condition.hide_in_width,
            highlight = {colors.green, colors.bg, 'bold'}
        }
    }, {
        FileFormatIcon = {
            provider = 'FileFormat',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            icon = ' ',
            condition = condition.hide_in_width,
            highlight = {colors.green, colors.bg, 'bold'}
        }
    }, {
        GitBranch = {
            provider = 'GitBranch',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            condition = condition.check_git_workspace,
            icon = ' ',
            highlight = {colors.violet, colors.bg, 'bold'}
        }
    }, {
        DiffAdd = {
            provider = 'DiffAdd',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            condition = condition.hide_in_width,
            icon = ' ',
            highlight = {colors.green, colors.bg}
        }
    }, {
        DiffModified = {
            provider = 'DiffModified',
            condition = condition.hide_in_width,
            icon = ' ',
            highlight = {colors.orange, colors.bg}
        }
    }, {
        DiffRemove = {
            provider = 'DiffRemove',
            condition = condition.hide_in_width,
            icon = ' ',
            highlight = {colors.red, colors.bg}
        }
    }, {
        ViMode = {
            provider = gl_rainbow,
            separator = ' ',
            separator_highlight = {'NONE', colors.bg}
        }
    }
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
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            condition = condition.buffer_not_empty,
            highlight = {colors.fg, colors.bg, 'bold'}
        }
    }
}

gls.short_line_right = {
    {BufferIcon = {provider = 'BufferIcon', highlight = {colors.fg, colors.bg}}}
}
