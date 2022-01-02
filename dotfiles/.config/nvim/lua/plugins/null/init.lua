local null_pyment = require("plugins.null.pyment")
local null_radicale = require("plugins.null.radicale")
local null_notmuch = require("plugins.null.notmuch")

local null_ls = require("null-ls")

null_ls.setup({
    debug = false,
    diagnostics_format = "[#{c}] #{m} (#{s})",
    on_attach = require("lspconfig.utils").on_attach,
    sources = {
        -- Python
        null_ls.builtins.formatting.isort.with({ extra_args = { "--float-to-top" } }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8.with({
            extra_args = { "--config", os.getenv("HOME") .. "/.config/flake8" },
        }),
        -- Shell
        null_ls.builtins.diagnostics.shellcheck,
        -- Lua
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
        -- Prose / Text
        null_ls.builtins.diagnostics.write_good.with({
            filetypes = { "markdown", "mail", "rst", "asciidoc", "tex" },
            diagnostics_format = "#{m} (#{s})",
        }),
        null_ls.builtins.diagnostics.vale.with({
            extra_args = {
                "--config=" .. vim.fn.expand("~/.config/vale/style.ini"),
            },
            filetypes = { "markdown", "mail", "rst", "asciidoc" },
        }),
        null_ls.builtins.hover.dictionary.with({ -- show meaning on hover
            filetypes = { "markdown", "mail", "rst", "asciidoc", "tex" },
        }),
        -- null_ls.builtins.completion.spell.with({
        --     filetypes = { "markdown", "mail", "rst", "asciidoc", "tex" },
        -- }),
        null_radicale,
        null_notmuch,
        null_pyment,
    },
})
