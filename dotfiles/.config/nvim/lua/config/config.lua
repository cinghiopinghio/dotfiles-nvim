vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = {
        spacing = 4,
        source = "always",
        prefix = "❱",
    },
    float = {
        pad_top = 0,
        pad_bottom = 0,
        border = "single",
    },
    update_in_insert = false,
    severity_sort = true,
})
