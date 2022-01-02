local lspconfig = require("lspconfig")

local lsp_protocol = require("vim.lsp.protocol")
local attach_callback = require("lspconfig.utils").on_attach

local capabilities = lsp_protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
    "bashls",
    "rls",
    "vimls",
    "jedi_language_server",
    "tsserver",
    "ansiblels",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = attach_callback,
        capabilities = capabilities,
    })
end

lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = attach_callback,
    cmd = { "vscode-html-languageserver", "--stdio" },
})

lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    cmd = { "/usr/bin/lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
    on_attach = attach_callback,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lspconfig.texlab.setup({
    -- capabilities = capabilities,
    on_attach = attach_callback,
    filetypes = { "tex", "bib" },
    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = { "-lualatex", "-pvc", "-interaction=nonstopmode", "-synctex=1", "%f" },
                forwardSearchAfter = true,
                onSave = false,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 100,
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
                onSave = true,
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single",
    pad_top = 0,
    pad_bottom = 0,
})

vim.lsp.handlers["textDocument/rename"] = function(err, result)
    if err then
        vim.notify(("Error running lsp query 'rename': " .. err), vim.log.levels.ERROR)
    end
    if result and result.changes then
        local msg = ""
        for f, c in pairs(result.changes) do
            local new = c[1].newText
            msg = msg .. ("%d changes -> %s"):format(#c, f:gsub("file://", ""):gsub(vim.fn.getcwd(), ".")) .. "\n"
            msg = msg:sub(1, #msg - 1)
            vim.notify(msg, vim.log.levels.INFO, {
                title = ("Rename: %s -> %s"):format(vim.fn.expand("<cword>"), new),
            })
        end
    end
    vim.lsp.util.apply_workspace_edit(result)
end

vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<F2>",
    "<cmd>lua requite('lspconfig.utils').rename()<cr>",
    { noremap = true, silent = true }
)
