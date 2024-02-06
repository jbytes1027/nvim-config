return {
    {
        "stevearc/aerial.nvim",
        opts = {
            -- Priority list of preferred backends for aerial.
            backends = { "treesitter", "lsp", "markdown", "man" },
            post_jump_cmd = "normal! zt",
            highlight_on_jump = false,
            highlight_on_hover = false, -- Highlight the symbol in the source buffer when cursor is in the aerial win
            autojump = true,
            close_on_select = true, -- When true, aerial will automatically close after jumping to a symbol
            preserve_equality = true,
            default_direction = "right",

            keymaps = {
                ["?"] = false,
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.jump",
                ["<2-LeftMouse>"] = "actions.jump",
                ["<C-v>"] = "actions.jump_vsplit",
                ["<C-s>"] = "actions.jump_split",
                ["p"] = "actions.scroll",
                ["<C-j>"] = "actions.down_and_scroll",
                ["<C-k>"] = "actions.up_and_scroll",
                ["{"] = "actions.prev",
                ["}"] = "actions.next",
                ["["] = "actions.prev_up",
                ["]"] = "actions.next_up",
                ["q"] = "actions.close",
                ["o"] = "actions.tree_toggle",
                ["za"] = "actions.tree_toggle",
                ["O"] = "actions.tree_toggle_recursive",
                ["zA"] = "actions.tree_toggle_recursive",
                ["l"] = "actions.tree_open",
                ["zo"] = "actions.tree_open",
                ["L"] = "actions.tree_open_recursive",
                ["zO"] = "actions.tree_open_recursive",
                ["h"] = "actions.tree_close",
                ["zc"] = "actions.tree_close",
                ["H"] = "actions.tree_close_recursive",
                ["zC"] = "actions.tree_close_recursive",
                ["zr"] = "actions.tree_increase_fold_level",
                ["zR"] = "actions.tree_open_all",
                ["zm"] = "actions.tree_decrease_fold_level",
                ["zM"] = "actions.tree_close_all",
                ["zx"] = "actions.tree_sync_folds",
                ["zX"] = "actions.tree_sync_folds",
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
        },
    },
    {
        "tommcdo/vim-ninja-feet",
    },
    {
        "jessekelighine/vindent.vim",
        init = function()
            vim.g.vindent_motion_OO_prev = "[i" -- jump to prev block of same indent.
            vim.g.vindent_motion_OO_next = "]i" -- jump to next block of same indent.
            vim.g.vindent_motion_more_prev = "[+" -- jump to prev line with more indent.
            vim.g.vindent_motion_more_next = "]+" -- jump to next line with more indent.
            vim.g.vindent_motion_less_prev = "[-" -- jump to prev line with less indent.
            vim.g.vindent_motion_less_next = "]-" -- jump to next line with less indent.
            vim.g.vindent_motion_diff_prev = "[;" -- jump to prev line with different indent.
            vim.g.vindent_motion_diff_next = "];" -- jump to next line with different indent.
            vim.g.vindent_motion_XX_ss = "[p" -- jump to start of the current block scope.
            vim.g.vindent_motion_XX_se = "]p" -- jump to end   of the current block scope.
            vim.g.vindent_object_XX_ii = "ii" -- select current block.
            vim.g.vindent_object_XX_ai = "ai" -- select current block + one extra line  at beginning.
            vim.g.vindent_object_XX_aI = "aI" -- select current block + two extra lines at beginning and end.
            vim.g.vindent_jumps = 1 -- make vindent motion count as a |jump-motion| (works with |jumplist|).
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                ignore_install = { "markdown" },

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
            motions = {
                count = false,
            },
            plugins = {
                set_mark = true,
            },
            triggers_nowait = {
                -- marks
                "m",
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                '"',
                "<c-r>",
                -- spelling
                "z=",
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- see https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    path_display = { "truncate" },
                    layout_config = {
                        horizontal = { prompt_position = "top" },
                    },
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                            ["<C-h>"] = function() vim.api.nvim_input("<C-w>") end, -- enable ctrl-backspace
                        },
                    },
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signcolumn = false,
            numhl = false,
            update_debounce = 200,
        },
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
    },
    {
        "williamboman/mason.nvim",
        opts = {}, -- force calling setup
    },
    {
        "nvimtools/none-ls.nvim",
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
            null_ls.setup({
                sources = { -- see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/HELPERS.md
                    -- Anything not supported by mason.
                    -- dotnet_format,
                },
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
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
    },
    {
        "williamboman/mason-lspconfig.nvim",
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
                        cmd = { -- see https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options for options
                            "omnisharp",
                            "RoslynExtensionsOptions:EnableAnalyzersSupport=true",
                            "RoslynExtensionsOptions:EnableImportCompletion=false", -- show items not imported - makes completion slower
                            "RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true",
                            "RoslynExtensionsOptions:enableDecompilationSupport=true",
                            "omnisharp.enableEditorConfigSupport=true",
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
        "j-hui/fidget.nvim",
        opts = {
            progress = {
                ignore_empty_message = false, -- Ignore new tasks that don't contain a message
            },
            notification = {
                override_vim_notify = true, -- Automatically override vim.notify() with Fidget
                window = {
                    x_padding = 0,
                    normal_hl = "NormalFloat",
                    border_hl = "NormalFloat",
                    winblend = 0,
                    border = { "", "", "", " ", "", "", "", " " },
                },
                view = {
                    group_separator = false,
                },
            },
        },
    },
    {
        "numToStr/Comment.nvim",
    },
    {
        enabled = jit.os ~= "Windows",
        "kelly-lin/ranger.nvim",
        opts = { replace_netrw = true },
    },
    {
        "mrjones2014/smart-splits.nvim",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
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
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp", priority = 1000 },
                    -- { name = "luasnip",  priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                }),
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
}