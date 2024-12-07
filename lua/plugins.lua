return {
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        opts = function()
            local aerial_keymap = require("keybindings").aerial_keymap

            return {
                -- Priority list of preferred backends for aerial.
                backends = { "treesitter", "lsp", "markdown", "man" },
                post_jump_cmd = "normal! zt",
                highlight_on_jump = false,
                highlight_on_hover = false, -- Highlight the symbol in the source buffer when cursor is in the aerial win
                autojump = true,
                close_on_select = true, -- When true, aerial will automatically close after jumping to a symbol
                preserve_equality = true,
                default_direction = "right",

                keymaps = aerial_keymap,

                ignore = {
                    unlisted_buffers = false,
                    filetypes = {},
                    buftypes = false,
                    wintypes = "special",
                },

                layout = {
                    min_width = { 15 },
                    width = 40,
                    max_width = { 0.5 },
                    win_opts = {
                        number = true,
                        relativenumber = true,
                    },
                },

                nav = {
                    min_height = { 20, 0.85 },
                    min_width = { 0.3, 20 },
                    -- max_width = 0.8,
                    -- max_height = 0.8,

                    win_opts = {
                        winblend = 0,
                        winhl = "NormalFloat:Normal,FloatBorder:Normal",
                        number = true,
                        relativenumber = true,
                    },
                    preview = true,
                },
            }
        end,
    },
    {
        "tommcdo/vim-ninja-feet",
        event = "VeryLazy",
    },
    {
        "michaeljsmith/vim-indent-object",
        event = "VeryLazy",
    },
    {
        "jeetsukumaran/vim-indentwise",
        event = "VeryLazy",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        enabled = vim.fn.executable("cc") == 1
            or vim.fn.executable("gcc") == 1
            or vim.fn.executable("clang") == 1
            or vim.fn.executable("cl") == 1
            or vim.fn.executable("zig") == 1,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                -- List of parsers to ignore installing (or "all")
                ignore_install = { "diff" },

                highlight = {
                    enable = true,

                    -- Disable slow treesitter highlight for large files
                    disable = function(_, buf)
                        local max_filesize = 1000 * 1024 -- 1000 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then return true end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
        opts = { -- See https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
            plugins = {
                set_mark = true,
            },
            icons = {
                mappings = false,
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- see https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
            require("telescope").setup({
                defaults = {
                    scroll_strategy = "limit",
                    sorting_strategy = "ascending",
                    path_display = { "truncate" },
                    layout_config = {
                        horizontal = { prompt_position = "top" },
                        height = 0.90,
                        width = 0.90,
                    },
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                            ["<C-h>"] = function() vim.api.nvim_input("<C-w>") end, -- enable ctrl-backspace
                            ["<C-f>"] = require("telescope.actions").results_scrolling_down,
                            ["<C-b>"] = require("telescope.actions").results_scrolling_up,
                            ["<C-/>"] = require("telescope.actions").which_key,
                            ["<C-u>"] = { "<C-o>dd", type = "command" },
                        },
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<C-e>"] = require("telescope.actions").delete_buffer,
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signcolumn = false,
            numhl = false,
            update_debounce = 200,
            preview_config = {
                border = "none",
                relative = "cursor",
                row = 1,
                col = 0,
            },
        },
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        event = "VeryLazy",
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {}, -- force calling setup
    },
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        dependencies = { "jay-babu/mason-null-ls.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local dotnet_format = {
                method = null_ls.methods.FORMATTING,
                filetypes = { "cs" },
                generator = null_ls.formatter({
                    command = "dotnet",
                    args = { "format", "--include", "$FILENAME" },
                    to_stdin = false,
                }),
            }
            local gdformat = {
                method = null_ls.methods.FORMATTING,
                filetypes = { "gdscript" },
                generator = null_ls.formatter({
                    command = "gdformat",
                    args = { "$FILENAME" },
                    to_temp_file = true,
                    from_temp_file = true,
                }),
            }
            null_ls.setup({
                sources = { -- see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/HELPERS.md
                    -- Anything not supported by mason.
                    -- dotnet_format,
                    gdformat,
                },
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        cmd = { "NullLsInstall", "NullLsUninstall" },
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                -- Opt to list sources here, when available in mason.
            },
            automatic_installation = false,
            handlers = {},
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            handlers = {
                -- The first entry (without a key) will be the default handler and will be called for each installed server that doesn't have a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({})
                end,

                -- Next, provide a dedicated handler for specific servers.
                ["omnisharp"] = function()
                    require("lspconfig").omnisharp.setup({
                        filetypes = { "cs", "vb", "csx" },
                        single_file_support = true,
                        cmd = { -- see https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options for options
                            "omnisharp",
                            "RoslynExtensionsOptions:EnableAnalyzersSupport=true",
                            "RoslynExtensionsOptions:EnableImportCompletion=false", -- show items not imported - makes completion slower
                            "RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true",
                            "RoslynExtensionsOptions:enableDecompilationSupport=true",
                            "omnisharp.enableEditorConfigSupport=true",
                            "script:enabled=true",
                        },
                        settings = {
                            ["dotnet.completion.showCompletionItemsFromUnimportedNamespaces"] = true,
                            ["dotnet.navigation.navigateToDecompiledSources"] = true,
                            ["dotnet.symbolSearch.searchReferenceAssemblies"] = true,
                            ["dotnet.quickInfo.showRemarksInQuickInfo"] = true,
                            ["omnisharp.enableDecompilationSupport"] = true,
                            ["omnisharp.enableAsyncCompletion"] = true,
                        },
                        handlers = {
                            ["textDocument/definition"] = require("omnisharp_extended").handler,
                        },
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({ -- see https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options for options
                        settings = {
                            Lua = {
                                format = {
                                    enable = false, -- use style lua
                                },
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = {
                                        "vim",
                                        "require",
                                    },
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                            },
                        },
                    })
                end,
            },
        },
    },
    {
        "jbytes1027/plain-lf.nvim",
        enabled = vim.fn.executable("lf") == 1,
        opts = {
            enable_cmds = true,
            replace_netrw = true,
        },
    },
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("cmp").setup({
                performance = {
                    debounce = 100,
                    throttle = 0,
                    fetching_timeout = 200,
                    confirm_resolve_timeout = 1,
                    async_budget = 200,
                },
                sources = require("cmp").config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                }),
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },
                matching = {
                    disallow_fuzzy_matching = true,
                    disallow_fullfuzzy_matching = true,
                    disallow_partial_fuzzy_matching = true,
                    disallow_partial_matching = true,
                    disallow_prefix_unmatching = true, -- prefix must match text
                },
                confirm_opts = {
                    behavior = require("cmp").ConfirmBehavior.Replace,
                    select = true,
                },
                view = {
                    docs = {
                        auto_open = true,
                    },
                },
                completion = {
                    autocomplete = false,
                },
                window = {
                    completion = {
                        scrollbar = true,
                    },
                },
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        -- follow latest release.
        version = "v2.*",
        config = function()
            local ls = require("luasnip")
            })
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets/" })
        end,
    },
}
