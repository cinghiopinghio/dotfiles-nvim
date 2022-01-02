-- require("cmp_nvim_lsp").setup()
local cmp = require("cmp")

local cmp_kinds = {
    Class = "ℂ  ",
    Color = "  ",
    Constant = "  ",
    Constructor = "+  ",
    Enum = "⁝  ",
    EnumMember = "•  ",
    Field = "↗  ",
    File = "  ",
    Folder = "  ",
    Function = "ƒ  ",
    Interface = "  ",
    Keyword = "  ",
    Method = "ƒ  ",
    Module = "  ",
    Property = "  ",
    Snippet = "﬌  ",
    Struct = "  ",
    Reference = "  ",
    Text = "  ",
    Unit = "μ  ",
    Value = "  ",
    Variable = "  ",
    Operator = "∈  ",
    Event = "  ",
    TypeParameter = "   ",
}

cmp.setup({
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
            return vim_item
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Insert,
        }),
        ["<TAB>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
    },
    snippet = {
        expand = function(args)
            require("snippy").expand_snippet(args.body)
        end,
    },
    min_lenght = 2,
    sources = {
        { name = "nvim_lsp" },
        { name = "snippy" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = "path" },
        { name = "nvim_lua" },
    },
})
