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
        tabnine = true,
        vsnip = true
    }
}

local km = require 'keymap'

function _G.smart_tab()
    if vim.fn.pumvisible() ~= 0 then
        return vim.fn['compe#confirm']()
    elseif vim.fn['vsnip#available'](1) == 1 then
        return km.to_keycodes '<Plug>(vsnip-expand-or-jump)'
    else
        return km.to_keycodes '<TAB>'
    end
end

km.map(km.mode.insert, '<TAB>', 'v:lua.smart_tab()',
       km.opts(km.optstr.expr, km.optstr.silent))

