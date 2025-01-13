return {
    {
        "ibhagwan/fzf-lua",
        opts = function()
            return {
                defaults = {
                    header = false,
                    file_icons = false,
                },
                winopts = {
                    height = 0.95,
                    width = 0.95,
                    row = 0.5,
                    col = 0.5,
                    border = "rounded",
                    backdrop = 0,
                    fullscreen = false,
                    treesitter = {
                        enabled = false,
                    },
                    preview = {
                        default = "builtin", -- builtin|bat|cat|head
                        wrap = false,
                        vertical = "down:45%", -- up|down:size
                        horizontal = "right:50%", -- right|left:size
                        layout = "flex", -- horizontal|vertical|flex
                        flip_columns = 120, -- #cols to switch to horizontal on flex
                        title = true, -- preview border title (file/buf)?
                        scrollbar = false, -- `false` or string:'float|border'
                        delay = 20, -- delay(ms) displaying the preview. prevents lag on fast scrolling
                        winopts = { -- builtin previewer window options
                            number = false,
                            relativenumber = false,
                            cursorline = true,
                            cursorlineopt = "both",
                            cursorcolumn = false,
                            signcolumn = "no",
                            list = false,
                            foldenable = false,
                            foldmethod = "manual",
                        },
                    },
                },
                hls = {
                    -- builtin preview only
                    cursor = "Cursor",
                    cursorline = "Visual",
                    cursorlinenr = "Visual",
                    search = "IncSearch",
                },
                previewers = {
                    builtin = {
                        syntax = true,
                        treesitter = {
                            enabled = false,
                        },
                    },
                },
                files = {
                    git_icons = false,
                    cwd_prompt = false,
                },
                grep = {
                    rg_opts = "--ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",

                    actions = {
                        -- actions inherit from 'actions.files' and merge
                        -- this action toggles between 'grep' and 'live_grep'
                        ["ctrl-g"] = { require("fzf-lua").actions.grep_lgrep },
                        -- uncomment to enable '.gitignore' toggle for grep
                        ["ctrl-r"] = { require("fzf-lua").actions.toggle_ignore },
                    },
                },
                lsp = {
                    cwd_only = false, -- LSP/diagnostics for cwd only?
                    symbols = {
                        prompt = " ",
                        symbol_style = 3, -- style for document/workspace symbols. false: disable, 1: icon+kind 2: icon only, 3: kind only
                        symbol_fmt = function(s, opts) return "[" .. s .. "]" end,
                        child_prefix = true,
                    },
                },
                keymap = {
                    -- Below are the default binds, setting any value in these tables will override
                    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
                    builtin = {
                        ["<M-w>"] = "toggle-preview-wrap",
                        ["<M-p>"] = "toggle-preview",
                        ["<M-r>"] = "toggle-preview-cw", -- Rotate preview clockwise
                        ["<M-d>"] = "preview-page-down",
                        ["<M-u>"] = "preview-page-up",
                        ["<M-e>"] = "preview-down",
                        ["<M-y>"] = "preview-up",
                    },
                    fzf = {
                        -- fzf '--bind=' options
                        ["ctrl-z"] = "abort",
                        ["ctrl-u"] = "unix-line-discard",
                        ["ctrl-f"] = "half-page-down",
                        ["ctrl-b"] = "half-page-up",
                        ["ctrl-a"] = "beginning-of-line",
                        ["ctrl-e"] = "end-of-line",
                        ["alt-a"] = "toggle-all",
                        ["alt-g"] = "first",
                        ["alt-G"] = "last",
                        ["ctrl-q"] = "select-all+accept",
                        -- Only valid with fzf previewers (bat/cat/git/etc)
                        ["alt-p"] = "toggle-preview",
                    },
                },
            }
        end,
    },
    {
        "Darazaki/indent-o-matic",
        opts = {
            -- Number of lines without indentation before giving up (use -1 for infinite)
            max_lines = 2048,

            -- Space indentations that should be detected
            standard_widths = { 2, 4, 8 },

            -- Skip multi-line comments and strings (more accurate detection but less performant)
            skip_multiline = true,
        },
    },
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
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown" },

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
                        local max_filesize = 100 * 1024 -- 100 KB
                        ---@diagnostic disable-next-line: undefined-field
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then return true end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = { "markdown" },
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
        opts = function()
            local opts = { -- See https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
                preset = "helix",
                win = {
                    border = "none",
                },
                plugins = {
                    marks = false,
                    marks_custom = true,
                },
                icons = {
                    mappings = false,
                    separator = "→",
                    keys = {},
                },
            }

            local spec_marks = {
                mode = { "n" },
                -- Filled out below
            }

            local low = function(i) return string.char(97 + i) end
            local upp = function(i) return string.char(65 + i) end

            for i = 0, 25 do
                table.insert(spec_marks, { "m" .. upp(i), hidden = true })
                table.insert(spec_marks, { "m" .. low(i), hidden = true })

                table.insert(spec_marks, { "'" .. upp(i), hidden = true })
                table.insert(spec_marks, { "'" .. low(i), hidden = true })

                table.insert(spec_marks, { "`" .. upp(i), hidden = true })
                table.insert(spec_marks, { "`" .. low(i), hidden = true })

                table.insert(spec_marks, { "g'" .. upp(i), hidden = true })
                table.insert(spec_marks, { "g'" .. low(i), hidden = true })

                table.insert(spec_marks, { "g`" .. upp(i), hidden = true })
                table.insert(spec_marks, { "g`" .. low(i), hidden = true })
            end

            if opts.spec == nil then opts.spec = {} end

            table.insert(opts.spec, spec_marks)

            return opts
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
        dependencies = { "jay-babu/mason-null-ls.nvim", "nvim-lua/plenary.nvim" },
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
        -- event = "VeryLazy",
        init = function()
            require("lspconfig").util.default_config =
                vim.tbl_extend("keep", require("lspconfig").util.default_config, {
                    before_init = function(params, config) vim.b.lsp_statusline_text = "..." end,
                    on_init = function(client, results) vim.b.lsp_statusline_text = "LSP" end,
                    on_attach = function(client, bufnr)
                        if client.server_capabilities.semanticTokensProvider ~= nil then
                            client.server_capabilities.semanticTokensProvider = nil
                        end
                        if client.server_capabilities.signatureHelpProvider then
                            require("lsp-overloads").setup(client, {
                                -- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
                                ui = {
                                    border = "none", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
                                    wrap = true, -- Wrap long lines
                                    wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
                                    max_width = nil, -- Maximum signature popup width
                                    max_height = nil, -- Maximum signature popup height
                                    -- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
                                    close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
                                    focusable = true, -- Make the popup float focusable
                                    focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
                                    silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
                                },
                                keymaps = {
                                    next_signature = "<C-j>",
                                    previous_signature = "<C-k>",
                                    next_parameter = "<C-l>",
                                    previous_parameter = "<C-h>",
                                    close_signature = "<A-s>",
                                    vim.api.nvim_buf_set_keymap(
                                        bufnr,
                                        "i",
                                        "<C-k>",
                                        "<cmd>LspOverloadsSignature<CR>",
                                        {}
                                    ),
                                },
                                display_automatically = false, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
                            })
                        end
                    end,
                    on_exit = function(code, signal, client_id) vim.b.lsp_statusline_text = "" end,
                })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        -- event = "VeryLazy",
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
                        settings = { -- see https://github.com/OmniSharp/omnisharp-roslyn/tree/master/src/OmniSharp.Shared/Options for options
                            RoslynExtensionsOptions = {
                                DocumentAnalysisTimeoutMs = 30000,
                                EnableDecompilationSupport = true,
                                -- Enables support for showing unimported types and unimported extension
                                -- methods in completion lists. When committed, the appropriate using
                                -- directive will be added at the top of the current file. This option can
                                -- have a negative impact on initial completion responsiveness,
                                -- particularly for the first few completion sessions after opening a
                                -- solution.
                                EnableImportCompletion = true,
                                EnableAsyncCompletion = true,
                                -- Enables support for roslyn analyzers, code fixes and rulesets.
                                EnableAnalyzersSupport = true,
                                -- Only run roslyn analyzers against open files
                                AnalyzeOpenDocumentsOnly = false,
                                InlayHintsOptions = {
                                    EnableForParameters = true,
                                    ForLiteralParameters = true,
                                    ForIndexerParameters = true,
                                    ForObjectCreationParameters = true,
                                    ForOtherParameters = true,
                                    SuppressForParametersThatDifferOnlyBySuffix = false,
                                    SuppressForParametersThatMatchMethodIntent = false,
                                    SuppressForParametersThatMatchArgumentName = false,
                                    EnableForTypes = true,
                                    ForImplicitVariableTypes = true,
                                    ForLambdaParameterTypes = true,
                                    ForImplicitObjectCreation = true,
                                },
                            },
                            Script = {
                                Enabled = true,
                                DefaultTargetFramework = "net461",
                                EnableScriptNuGetReferences = false,
                            },
                            FormattingOptions = {
                                EnableEditorConfigSupport = true,
                            },
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
            ui = {
                height = 0.95,
                width = 0.95,
            },
        },
    },
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
    },
    {
        "Issafalcon/lsp-overloads.nvim",
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
                    debounce = 10,
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
            local types = require("luasnip.util.types")
            ls.setup({
                ext_opts = {
                    [types.insertNode] = {
                        unvisited = {
                            virt_text = { { " ", "SnippetTabstop" } },
                            virt_text_pos = "inline",
                        },
                    },
                    [types.exitNode] = {
                        unvisited = {
                            virt_text = { { " ", "SnippetTabstop" } },
                            virt_text_pos = "inline",
                        },
                    },
                },
            })
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets/" })
        end,
    },
}
