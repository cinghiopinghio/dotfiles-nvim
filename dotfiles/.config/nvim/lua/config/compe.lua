require('completion_vcard').setup_compe('~/casolin/casolin/dav/contacts/cp-contacts')
require('completion.notmuchaddress').setup_compe()

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
        buffer = { menu = '⟦B⟧' },
        calc = false,
        vsnip = false,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = false,
        snippets_nvim = false,
        treesitter = true,
        omni = false,
        ultisnips = true,
        vCard = true,
        notmuch = true,
        orgmode=true,
    }
}

-- auto expands snippets
vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', 'compe#confirm("<cr>")', { noremap=true, silent=true, expr=true })
