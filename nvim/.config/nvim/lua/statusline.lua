-- local cmd = vim.cmd
local colors = {
    bg = '#2c323c',
    fg = '#abb2bf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67'
}

require'feline'.setup()

local function git_branch() return vim.b.gitsigns_head end

local function git_added()
    return vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.added or 0
end

local function git_changed()
    return vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.changed or
               0
end

local function git_removed()
    return vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.removed or
               0
end

local function hide_info(func, expected, to)
    return function()
        local r = func()
        return r == expected and to or r
    end
end

local function func_eq(func, expected) return func() == expected end

-- galaxyline
--
-- local gl = require('galaxyline')
-- local colors = require('galaxyline.theme').default
-- local condition = require('galaxyline.condition')
-- local gls = gl.section
-- local glf = require('galaxyline.provider_fileinfo')
-- local lspclient = require('galaxyline.provider_lsp')

-- local mode_indicator = function()
--     -- auto change color according the vim mode
--     local mode_color = {
--         n = colors.green,
--         i = colors.blue,
--         v = colors.magenta,
--         [''] = colors.blue,
--         V = colors.magenta,
--         c = colors.magenta,
--         no = colors.red,
--         s = colors.orange,
--         S = colors.orange,
--         [''] = colors.orange,
--         ic = colors.yellow,
--         R = colors.violet,
--         Rv = colors.violet,
--         cv = colors.red,
--         ce = colors.red,
--         r = colors.cyan,
--         rm = colors.cyan,
--         ['r?'] = colors.cyan,
--         ['!'] = colors.red,
--         t = colors.red
--     }
--     cmd('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' ..
--             colors.bg)
--     return '▊'
-- end
-- 
-- -- gl.short_line_list = {'nvimtree', 'packer'}

-- gls.left = {
--     {ViMode = {provider = mode_indicator}}, {
--         FileSize = {
--             provider = file_size,
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             condition = condition.buffer_not_empty,
--             highlight = {colors.fg, colors.bg}
--         }
--     }, {
--         FileIcon = {
--             provider = 'FileIcon',
--             condition = condition.buffer_not_empty,
--             highlight = {
--                 require('galaxyline.provider_fileinfo').get_file_icon_color,
--                 colors.bg
--             }
--         }
--     }, {
--         FileName = {
--             provider = 'FileName',
--             condition = condition.buffer_not_empty,
--             highlight = {colors.fg, colors.bg, 'bold'}
--         }
--     }, {
--         PerCent = {
--             provider = 'LinePercent',
--             highlight = {colors.fg, colors.bg, 'bold'}
--         }
--     }, {
--         DiagnosticError = {
--             provider = 'DiagnosticError',
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             icon = ' ',
--             highlight = {colors.red, colors.bg}
--         }
--     }, {
--         DiagnosticWarn = {
--             provider = 'DiagnosticWarn',
--             icon = ' ',
--             highlight = {colors.yellow, colors.bg}
--         }
--     }, {
--         DiagnosticHint = {
--             provider = 'DiagnosticHint',
--             icon = ' ',
--             highlight = {colors.cyan, colors.bg}
--         }
--     }, {
--         DiagnosticInfo = {
--             provider = 'DiagnosticInfo',
--             icon = ' ',
--             highlight = {colors.blue, colors.bg}
--         }
--     }
-- }
-- 
-- gls.mid = {
--     {
--         ShowLspClient = {
--             provider = hide_info(lspclient.get_lsp_client, 'No Active Lsp', ''),
--             condition = function()
--                 local tbl = {['dashboard'] = true, [''] = true}
--                 if tbl[vim.bo.filetype] then return false end
--                 return true
--             end,
--             icon = '漣LSP: ',
--             highlight = {colors.yellow, colors.bg, 'bold'}
--         }
--     }
-- }
-- 
-- gls.right = {
--     {
--         FileEncode = {
--             provider = hide_info(glf.get_file_encode, ' UTF-8', ''),
--             condition = condition.hide_in_width,
--             highlight = {colors.green, colors.bg, 'bold'}
--         }
--     }, {
--         FileFormatIcon = {
--             provider = 'FileFormat',
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             icon = ' ',
--             condition = condition.hide_in_width,
--             highlight = {colors.green, colors.bg, 'bold'}
--         }
--     }, {
--         GitBranch = {
--             provider = git_branch,
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             condition = function()
--                 return not func_eq(git_branch, nil)
--             end,
--             icon = ' ',
--             highlight = {colors.violet, colors.bg, 'bold'}
--         }
--     }, {
--         DiffAdd = {
--             provider = git_added,
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             condition = function()
--                 return condition.hide_in_width() and not func_eq(git_added, 0)
--             end,
--             icon = ' ',
--             highlight = {colors.green, colors.bg}
--         }
--     }, {
--         DiffModified = {
--             provider = git_changed,
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             condition = function()
--                 return condition.hide_in_width() and not func_eq(git_changed, 0)
--             end,
--             icon = ' ',
--             highlight = {colors.orange, colors.bg}
--         }
--     }, {
--         DiffRemove = {
--             provider = git_removed,
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             condition = function()
--                 return condition.hide_in_width() and not func_eq(git_removed, 0)
--             end,
-- 
--             icon = ' ',
--             highlight = {colors.red, colors.bg}
--         }
--     }, {
--         ViMode = {
--             provider = mode_indicator,
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg}
--         }
--     }
-- }
-- 
-- gls.short_line_left = {
--     {
--         BufferType = {
--             provider = 'FileTypeName',
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             highlight = {colors.blue, colors.bg, 'bold'}
--         }
--     }, {
--         SFileName = {
--             provider = 'SFileName',
--             separator = ' ',
--             separator_highlight = {'NONE', colors.bg},
--             condition = condition.buffer_not_empty,
--             highlight = {colors.fg, colors.bg, 'bold'}
--         }
--     }
-- }
-- 
-- gls.short_line_right = {
--     {BufferIcon = {provider = 'BufferIcon', highlight = {colors.fg, colors.bg}}}
-- }
