M = {}

local lsp_signature = require("lsp_signature")
local lsp_protocol = require("vim.lsp.protocol")

M.on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    lsp_signature.on_attach({
        bind = true,
        -- doc_lines = 10,
        floating_window = true,
        fix_pos = true, -- set to true, the floating window will not auto-close until finish all parameters
        hint_enable = false,
        -- hint_prefix = "Hint: ",
        hint_scheme = "String",
        hi_parameter = "PmenuSel",
        handler_opts = { border = "single" },
        exta_trigger_chars = { "(" },
        zindex = 10,
    }, bufnr) -- Note: add in lsp client on-attach

    -- Mappings.
    local function map(key, cmd, bufnumber)
        vim.api.nvim_buf_set_keymap(bufnumber, "n", key, cmd, { noremap = true, silent = true })
    end
    -- Floating
    map("K", "<Cmd>lua vim.lsp.buf.hover()<CR>", bufnr)
    map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufnr)
    map("<C-d>", '<cmd>lua vim.diagnostic.open_float(0, {focusable=false, scope="line"})<CR>', bufnr)
    -- GoTo
    map("gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", bufnr)
    map("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufnr)
    map("]g", "<cmd>lua vim.diagnostic.goto_next({popup_opts = {}})<CR>", bufnr)
    map("[g", "<cmd>lua vim.diagnostic.goto_prev({popup_opts = {}})<CR>", bufnr)

    -- automatically format your file
    vim.cmd([[
        augroup autoformat
            autocmd!
            " the following command is syncronous so actual writing is done AFTER formatting
            autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync()
        augroup end
    ]])

    lsp_protocol.CompletionItemKind = {
        "", -- Text
        "", -- Method
        "", -- Function
        "", -- Constructor
        "", -- Field
        "", -- Variable
        "", -- Class
        "I", -- Interface
        "", -- Module
        "", -- Property
        "", -- Unit
        "", -- Value
        "⠇", -- Enum
        "", -- Keyword
        "﬌", -- Snippet
        "", -- Color
        "", -- File
        "", -- Reference
        "", -- Folder
        "", -- EnumMember
        "", -- Constant
        "", -- Struct
        "", -- Event
        "ﬦ", -- Operator
        "", -- TypeParameter,
    }
end

function M.rename()
    local currName = vim.fn.expand("<cword>")
    local tshl = require("nvim-treesitter-playground.hl-info").get_treesitter_hl()
    if tshl and #tshl > 0 then
        local ind = tshl[#tshl]:match("^.*()%*%*.*%*%*")
        tshl = tshl[#tshl]:sub(ind + 2, -3)
    end

    local win = require("plenary.popup").create(currName, {
        title = "New Name",
        style = "minimal",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        relative = "cursor",
        borderhighlight = "FloatBorder",
        titlehighlight = "Title",
        highlight = tshl,
        focusable = true,
        width = 25,
        height = 1,
        line = "cursor+2",
        col = "cursor-1",
    })

    local map_opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
    vim.api.nvim_buf_set_keymap(
        0,
        "i",
        "<CR>",
        "<cmd>stopinsert | lua _rename('" .. currName .. "," .. win .. "')<CR>",
        map_opts
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<CR>",
        "<cmd>stopinsert | lua _rename('" .. currName .. "," .. win .. "')<CR>",
        map_opts
    )
end

function M._rename(curr, win)
    local newName = vim.trim(vim.fn.getline("."))
    vim.api.nvim_win_close(win, true)
    if #newName > 0 and newName ~= curr then
        local params = vim.lsp.util.make_position_params()
        params.newName = newName
        vim.lsp.buf_request(0, "textDocument/rename", params)
    end
end

return M
