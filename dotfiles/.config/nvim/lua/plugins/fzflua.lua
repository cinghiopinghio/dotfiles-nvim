require("fzf-lua").setup({
    winopts = {
        win_border = "rounded",
        hl = { normal = "NormalFloat", border = "FloatBorder", title = "PmenuSel" },
        preview = {
            title = true,
        },
    },
    fzf_opts = {
        ["--border"] = "none",
    },
})
