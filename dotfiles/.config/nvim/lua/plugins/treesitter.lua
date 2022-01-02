local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.org = {
    install_info = {
        url = "https://github.com/milisims/tree-sitter-org",
        revision = "main",
        files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "org",
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "bibtex",
        "comment",
        "css",
        "html",
        "javascript",
        "jsonc",
        "latex",
        "lua",
        "markdown",
        "org",
        "python",
        "rst",
        "rust",
        "scss",
        "toml",
        "yaml",
        "vim",
    }, -- one of "all", "language", "maintained", or a list of languages
    autotag = { enable = true },
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
    },
    select = {
        enable = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<localleader>ss",
            scope_incremental = "<localleader>sa",
            node_incremental = "+",
            node_decremental = "-",
        },
    },
    indent = {
        enable = false,
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "gd",
            },
        },
    },
    playground = {
        enable = true,
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<a-right>"] = "@parameter.inner",
            },
            swap_previous = {
                ["<a-left>"] = "@parameter.inner",
            },
        },
    },
    lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
            ["<localleader>sf"] = "@function.outer",
            ["<localleader>sF"] = "@class.outer",
        },
    },
    tree_docs = { enable = false },
})

require("treesitter-context").setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
})
