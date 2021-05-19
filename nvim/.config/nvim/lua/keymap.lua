local wk = require 'which-key'
local utils = require 'utils'

local mode = {
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

local function kmap(m, lhs, rhs, ...)
    local opts = {...}
    local t = {}
    for _, v in ipairs(opts) do t[v] = true end
    vim.api.nvim_set_keymap(m, lhs, rhs, t)
end

local function cmd(s) return '<Cmd>' .. s .. '<CR>' end
local function plug(s) return '<Plug>' .. s end

function _G.smart_tab()
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({'selected'}).selected ~=
        -1 then
        return vim.fn['compe#confirm']()
    elseif vim.fn['vsnip#available'](1) == 1 then
        return utils.to_keycodes '<Plug>(vsnip-expand-or-jump)'
    else
        return utils.to_keycodes '<TAB>'
    end
end

-- LuaFormatter off

-- Keymap Principles
-- 1. Balance two hands.
-- 2. As few as possible keystrokes.
-- 3. Map the most frequently functions to repected keystrokes.
-- 4. Semantic mappings.
-- 5. A key on the home row is expected if it can't meet the principle 4.

local left_hand = {
    'q', 'w', 'e', 'r', 't',
       'a', 's', 'd', 'f', 'g',
          'z', 'x', 'c', 'v', 'b'
}

local right_hand = {
    'y', 'u', 'i', 'o', 'p',
       'h', 'j', 'k', 'l',
          'n', 'm'
}

-- LuaFormatter on

local function not_both_in_tbl(tbl, v1, v2)
    return not (vim.tbl_contains(tbl, v1) and vim.tbl_contains(tbl, v2))
end

-- Verify if the mappings balance two hands
local function verify_maps(mappings)
    for k, v in pairs(mappings) do
        if type(v) == 'table' and v.name ~= nil then
            for k2, _ in pairs(v) do
                assert(k2 == 'name' or k == k2 or
                           (not_both_in_tbl(left_hand, k, k2) and
                               not_both_in_tbl(right_hand, k, k2)),
                       'Mappings Didn\'t Balance Two Hands: ' .. k .. k2)
            end
        end
    end
end

-- LuaFormatter off

local normal_map = {
    p = {
        name = 'Plugins Manager',
        p = {cmd('PackerSync'), 'PackerSync'},
        c = {cmd('PackerClean'), 'PackerClean'},
        d = {cmd('PackerUpdate'), 'PackerUpdate'},
        e = {cmd('PackerCompile'), 'PackerCompile'},
        s = {cmd('PackerStatus'), 'PackerStatus'},
        t = {cmd('PackerInstall'), 'PackerInstall'}
    },
    t = {
        name = 'Terminal',
        t = {cmd('<c-u>exe v:count1 . "ToggleTerm"'), 'Embeded Float Terminal'},
        m = {cmd('terminal'), 'Terminal'}
    },
    o = {
        name = 'Code Action',
        o = {cmd('Neoformat'), 'Neoformat'},
        t = {':Tabularize /', 'Align'},
        f = {cmd('Lspsaga lsp_finder'), 'Find definitions and references'},
        a = {cmd('Lspsaga code_action'), 'Code Action By LSP'},
        r = {cmd('Lspsaga rename'), 'Rename'},
        c = {plug('kommentary_line_default'), 'Comment'},
        s = {cmd('Codi'), 'Run REPL'},
        d = {cmd('Codi!'), 'Close REPL'}
    },
    e = {
        name = 'Explorer',
        e = {cmd('NvimTreeToggle'), 'NvimTree'},
        j = {cmd('RnvimrToggle'), 'Ranger'}
    },
    s = {
        name = 'Search',
        s = {cmd('Telescope live_grep'), 'Grep'},
        j = {cmd('Telescope find_files'), 'Files'},
        k = {cmd('Telescope buffers'), 'Buffers'},
        h = {cmd('Telescope help_tags'), 'Help'}
    },
    f = {
        name = 'File',
        f = {cmd('set filetype='), 'Set FileType'}
    },
    b = {
        name = 'Buffer',
        b = {cmd('BufferPick'), 'BufferPick'},
        h = {cmd('BufferPrevious'), 'BufferPrevious'},
        l = {cmd('BufferNext'), 'BufferNext'},
        j = {cmd('BufferClose'), 'BufferClose'},
    },
    r = {
        name = 'Root action',
        r = {cmd('SudaWrite'), 'Write as Root'},
        j = {cmd('SudaRead'), 'Read as Root'},
    },
    c = {
        name = 'Clipboard',
        p = {cmd('%y+'), 'Copy Buffer'},
    },
    w = {cmd('w'), 'Save'},
    q = {cmd('q'), 'Quit'},
    Q = {cmd('q!'), 'Force Quit'}
}

local visual_map = {
    o = {
        name = 'Code Action',
        o = {cmd('Neoformat'), 'Neoformat'},
        t = {cmd('Tabularize /'), 'Align'},
        a = {cmd('Lspsaga range_code_action'), 'Code Action By LSP'},
        c = {plug('kommentary_visual_default'), 'Comment'},
        s = {cmd('Codi'), 'Run REPL'},
        d = {cmd('Codi!'), 'Close REPL'}
    },
    c = {
        name = 'Clipboard',
        p = {'\"+y', 'Copy Selection'}
    }
}

verify_maps(normal_map)
verify_maps(visual_map)

wk.register(normal_map,
{
    prefix = '<leader>',
    mode = mode.normal,
    noremap = true,
    silent = true
})

wk.register(visual_map,
{
    prefix = '<leader>',
    mode = mode.visual,
    noremap = true,
    silent = true
})

-- LuaFormatter on

-- Other mappings

kmap(mode.normal, '<C-j>', '<C-w>j', 'noremap')
kmap(mode.normal, '<C-k>', '<C-w>k', 'noremap')
kmap(mode.normal, '<C-h>', '<C-w>h', 'noremap')
kmap(mode.normal, '<C-l>', '<C-w>l', 'noremap')
kmap(mode.terminal, '<C-j>', [[<C-\><C-n><C-w>j]], 'noremap')
kmap(mode.terminal, '<C-k>', [[<C-\><C-n><C-w>k]], 'noremap')
kmap(mode.terminal, '<C-h>', [[<C-\><C-n><C-w>h]], 'noremap')
kmap(mode.terminal, '<C-l>', [[<C-\><C-n><C-w>l]], 'noremap')

kmap(mode.normal, 'K', cmd('Lspsaga hover_doc'), 'noremap', 'silent')
kmap(mode.insert, '<TAB>', 'v:lua.smart_tab()', 'expr', 'silent')

