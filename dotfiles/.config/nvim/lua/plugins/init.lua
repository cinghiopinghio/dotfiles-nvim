local packer = require("packer")

package.loaded["packer.nvim"] = nil -- Refresh package list

local function load_conf(name)
    require("plugins." .. name)
end

local pack_conf = {
    max_jobs = 10,
    profile = {
        enable = true,
        threshols = 1,
    },
}

-- auto compile on write
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins_packer.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup({
    function(use)
        use({
            "wbthomason/packer.nvim", -- plugin manager
        }) -- Let packer manage itself

        --------------------
        -- TPope
        --------------------
        use("tpope/vim-commentary") -- comment uncomment with gcc
        use("tpope/vim-speeddating") -- increase/decrease dates with c-a c-x
        use("tpope/vim-surround") -- quoting/parenthesis mae easy

        --------------------
        -- Visual
        --------------------
        use({
            "romainl/vim-cool", -- plugin to remove search highlight once the cursor moved
            disable = false,
        })
        use({ "DanilaMihailov/beacon.nvim" }) -- highlight coursor on jumps
        use({
            "lukas-reineke/indent-blankline.nvim", -- show indentation guidelines
            disable = false,
            config = function()
                vim.g.indent_blankline_filetype_exclude = { "tex", "markdown", "help", "no ft" }
                vim.g.indent_blankline_buftype_exclude = { "terminal" }
                vim.g.indent_blankline_char = "▏"
                vim.g.indent_blankline_context_char = "▍"
                vim.g.indent_blankline_use_treesitter = true
                vim.g.indent_blankline_show_trailing_blankline_indent = true
                vim.cmd([[highlight link IndentBlanklineContextChar Conceal]])
                require("indent_blankline").setup({
                    space_char_blankline = " ",
                    show_current_context = true,
                    show_current_context_start = true,
                })
            end,
        })
        use({
            "nvim-lualine/lualine.nvim",
            config = load_conf("lualine"),
        })
        use({
            "HiPhish/desktop-notify-nvim",
            config = function()
                vim.notify = require("desktop_notify").notify_send
            end,
        })

        --------------------
        -- Utils
        --------------------
        -- use("ggandor/lightspeed.nvim")
        use({
            "bootleq/vim-cycle", --  word editing (ctrl-A)
            config = function()
                vim.g.cycle_no_mappings = 1 -- just set my keys
                vim.g.cycle_max_conflict = 1 -- do not handle conflicts (better performance)
                vim.g.cycle_default_groups = {
                    { { "true", "false" } },
                    { { "yes", "no" } },
                    { { "on", "off" } },
                    { { "+", "-" } },
                    { { ">", "<" } },
                    { { "min", "max" } },
                    { { "{:}", "[:]", "(:)" }, "sub_pairs" },
                }
                vim.g.cycle_default_groups_for_tex = {
                    {
                        {
                            "tiny",
                            "scriptsize",
                            "footnotesize",
                            "small",
                            "normalsize",
                            "large",
                            "Large",
                            "LARGE",
                            "huge",
                            "Huge",
                        },
                        "hard_case",
                        "match_case",
                    },
                    { { "part", "chapter", "section", "subsection", "subsubsection", "paragraph", "subparagraph" } },
                    {
                        { "\big(:\big)", "\\Big(:\\Big)", "\bigg(:\bigg)", "\\Bigg(:\\Bigg)" },
                        "sub_pairs",
                        "hard_case",
                        "match_case",
                    },
                    {
                        { "\big[:\big]", "\\Big[:\\Big]", "\bigg[:\bigg]", "\\Bigg[:\\Bigg]" },
                        "sub_pairs",
                        "hard_case",
                        "match_case",
                    },
                    {
                        { "\big\\{:\big\\}", "\\Big\\{:\\Big\\}", "\bigg\\{:\bigg\\}", "\\Bigg\\{:\\Bigg\\}" },
                        "sub_pairs",
                        "hard_case",
                        "match_case",
                    },
                    {
                        { "\big\\l:\big\r", "\\Big\\l:\\Big\r", "\bigg\\l:\bigg\r", "\\Bigg\\l:\\Bigg\r" },
                        "sub_pairs",
                        "hard_case",
                        "match_case",
                    },
                    { { "\big", "\\Big", "\bigg", "\\Bigg" }, "hard_case", "match_case" },
                }
                vim.api.nvim_set_keymap("n", "<C-A>", "<plug>CycleNext", { noremap = false, silent = true })
                vim.api.nvim_set_keymap("n", "<C-X>", "<plug>CyclePrev", { noremap = false, silent = true })
                vim.api.nvim_set_keymap("n", "<plug>CycleFallbackNext", "<C-A>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<plug>CycleFallbackPrev", "<C-X>", { noremap = true, silent = true })
            end,
        })
        use({
            "jiangmiao/auto-pairs", --  complete parenthesis
        })
        use({
            "junegunn/fzf", -- fuzzy search
            run = ":call fzf#install()",
        })
        use({
            "voldikss/vim-floaterm",
            config = function()
                vim.g.floaterm_keymap_toggle = "<F12>"
                vim.g.floaterm_winblend = 20
                vim.g.floaterm_position = "center"
                vim.g.floaterm_autoclose = 1
            end,
        })
        use({
            "voldikss/fzf-floaterm",
            config = function()
                vim.g.fzf_floaterm_newentries = {
                    _lazygit = {
                        title = " Lazygit ",
                        cmd = "lazygit",
                    },
                    _bpython = {
                        title = " BPython ",
                        cmd = "bpython",
                        wintype = "vsplit",
                        position = "right",
                    },
                    _nnn = {
                        title = " NNN ",
                        cmd = "nnn",
                    },
                    _ipython = {
                        title = " IPython ",
                        cmd = "ipython",
                        wintype = "vsplit",
                        position = "right",
                    },
                }
                vim.api.nvim_set_keymap("n", "<f11>", "<cmd>:Floaterms<cr>", { noremap = true, silent = true })
            end,
            requires = {
                {
                    "junegunn/fzf",
                    run = ":call fzf#install()",
                },
            },
        })
        use({
            "ibhagwan/fzf-lua",
            config = load_conf("fzflua"),
            -- requires = { "kyazdani42/nvim-web-devicons" },
        })
        use({
            "Konfekt/FastFold", -- keep folds as is until save of fold/unfold (save time)
            disable = true,
            config = function()
                vim.g.fastfold_savehook = false
            end,
        })
        use("hauleth/sad.vim") -- find and replace with s {substitute, search}
        use({
            "tommcdo/vim-lion", -- Align blocks
            config = function()
                vim.g.lion_squeeze_spaces = 1
            end,
            keys = { { "v", "gl" } },
        })
        -- use ({"AndrewRadev/sideways.vim"}) -- switch position of arguments
        -- now using treesitter
        use({
            "FooSoft/vim-argwrap", -- A plugin to expand args brtween parenthesis
            config = function()
                vim.api.nvim_set_keymap("n", "<localleader>a", "<cmd>:ArgWrap<cr>", { noremap = true, silent = true })
            end,
        })
        use({ "AndrewRadev/linediff.vim" }) -- show diffs between line ranges

        --------------------
        -- LSP
        --------------------
        use({
            "neovim/nvim-lspconfig", -- LSP Configuration
            config = load_conf("lspconfig"),
        })
        use("ray-x/lsp_signature.nvim") -- Auto show signature
        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = load_conf("null"),
            requires = { "nvim-lua/plenary.nvim" },
        })
        use({
            "liuchengxu/vista.vim",
            cmd = "Vista",
        })
        -- use({ "stevearc/aerial.nvim" })

        use({
            "airblade/vim-rooter", -- find root folder of the current project
            config = function()
                vim.g.rooter_targets = "*"
                vim.g.rooter_patterns = { ".git", "Makefile", "README.md" }
                vim.g.rooter_change_directory_for_non_project_files = "current"
            end,
        })
        use({
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup({
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    icons = false,
                    position = "right",
                    mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
                    action_keys = { -- key mappings for actions in the trouble list
                        jump = { "<cr>" }, -- jump to the diagnostic or open / close folds
                    },
                    padding = false, -- add an extra new line on top of the list
                    auto_open = true, -- automatically open the list when you have diagnostics
                    auto_close = true, -- automatically close the list when you have no diagnostics
                })
            end,
            disable = true,
        })

        use({
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            disable = true,
            config = function()
                require("lsp_lines").register_lsp_virtual_lines()
                -- Disable virtual_text since it's redundant due to lsp_lines.
                vim.diagnostic.config({
                    virtual_text = false,
                    virtual_lines = true,
                })
            end,
        })

        --------------------
        -- Completion
        --------------------
        use({
            "hrsh7th/nvim-cmp", -- vim completion
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
            },
            config = load_conf("cmp"),
        })
        use({
            "dcampos/nvim-snippy",
            requires = {
                "dcampos/cmp-snippy",
                "honza/vim-snippets",
            },
            config = {
                vim.cmd([[
                imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-next)' : '<Tab>'
                imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Tab>'
                smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
                smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Tab>'
            ]]),
            },
        })
        use("cbarrete/completion-vcard")

        ----------------
        -- Tree Sitter
        ----------------
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = load_conf("treesitter"),
        }) -- Tresitter
        use({ "romgrk/nvim-treesitter-context" }) -- Show context
        use("nvim-treesitter/nvim-treesitter-refactor")
        use("nvim-treesitter/playground") -- This is useful to check TS highlights
        use("nvim-treesitter/nvim-treesitter-textobjects")
        use({
            "nvim-treesitter/nvim-tree-docs",
            requires = { "nvim-treesitter/nvim-treesitter" },
        })

        --------------------
        -- Filetypes
        --------------------
        -- use({
        --     "nathom/filetype.nvim",
        --     disable = true,
        --     config = function()
        --         vim.g.did_load_filetypes = 1
        --     end,
        -- })
        use({
            "kristijanhusak/orgmode.nvim",
            config = function()
                require("orgmode").setup({
                    org_agenda_files = { "~/casolin/cindroid/orgmode/*" },
                    org_default_notes_file = "~/casolin/cindroid/orgmode/notes.org",
                })
            end,
        })
        use("freitass/todo.txt-vim") -- todo.txt syntax
        use({
            "lervag/vimtex", -- latex plugin
            disable = false,
        })
        use({
            "goerz/jupytext.vim",
            config = function()
                vim.g["jupytext_fmt"] = "py"
            end,
        })
        use({
            "iamcco/markdown-preview.nvim", -- markdown preview
            run = "cd app & yarn install",
        })
        use("ferrine/md-img-paste.vim") -- paste images on markdown

        --------------------
        -- Color
        --------------------
        use("lifepillar/vim-colortemplate")
        use("andreypopp/vim-colors-plain")
        use("pgdouyon/vim-yin-yang")
        use("axvr/photon.vim")
        use("tomasr/molokai")
        -- use 'norcalli/nvim-colorizer.lua' -- show colorized background of colors
        use({
            "RRethy/vim-hexokinase",
            run = "make hexokinase",
            config = 'vim.g.Hexokinase_optInPatterns="full_hex,rgb,rgba,hsl,hsla"; vim.g.Hexokinase_virtualText="██"',
        })
        use("KabbAmine/vCoolor.vim") -- run the OS color picker

        --------------------
        -- Prose
        --------------------

        -- use 'rhysd/vim-grammarous'
        -- use 'vigoux/LanguageTool.nvim'
        -- let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool-server.jar'
        -- use 'reedes/vim-wordy'
        use({
            "brymer-meneses/grammar-guard.nvim", -- languagetool as lsp
            requires = "neovim/nvim-lspconfig",
        })
        use({
            "davidbeckingsale/writegood.vim",
            disable = true,
        })
    end,
    config = pack_conf,
})
