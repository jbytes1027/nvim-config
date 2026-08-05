return {
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        config = function()
            require("keybindings").setup_fzf_lua_keybindings()

            require("fzf-lua").setup({
                defaults = {
                    header = false,
                    file_icons = false,
                    copen = "FzfLua quickfix",
                    lopen = "FzfLua loclist",
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
                            enabled = true,
                        },
                        ext_ft_override = {
                            ["js"] = "text",
                            ["css"] = "text",
                        },
                    },
                },
                files = {
                    files = { fzf_opts = { ["--ansi"] = false } },
                    git_icons = false,
                    cwd_prompt = false,
                },
                grep = {
                    fzf_opts = { ["--ansi"] = false },
                    rg_glob = true, -- true required for windows support
                    rg_opts = "--column --line-number --no-heading --color=never --smart-case --max-columns=4096 -e",

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
                quickfix = {
                    actions = {
                        ["ctrl-x"] = {
                            reload = false,
                            fn = function(selected, opts)
                                print(vim.inspect(opts.__reload_cmd))

                                -- Inspired from fzf-lua/actions.lua
                                local list_to_remove = {}
                                for i = 1, #selected do
                                    local file = require("fzf-lua").path.entry_to_file(selected[i], opts)
                                    local text = file.stripped:match(":%d+:%d?%d?%d?%d?:?(.*)$")
                                    table.insert(list_to_remove, {
                                        bufnr = file.bufnr,
                                        filename = file.bufname or file.path or file.uri,
                                        lnum = file.line > 0 and file.line or 1,
                                        col = file.col,
                                        text = text,
                                    })
                                end

                                -- Get the current quickfix list
                                local quickfix_list = vim.fn.getqflist()

                                local filtered_list = vim.tbl_filter(function(qf_item)
                                    for _, value in pairs(list_to_remove) do
                                        if value.lnum == qf_item.lnum and value.col == qf_item.col then
                                            local filename = vim.api.nvim_buf_get_name(qf_item.bufnr)

                                            if value.bufnr == qf_item.bufnr or value.filename == filename then
                                                return false
                                            end
                                        end
                                    end
                                    return true
                                    -- return not string.match(item.text, selected)
                                end, quickfix_list)

                                -- Update the quickfix list with the filtered list
                                vim.fn.setqflist(filtered_list, "r")

                                require("fzf-lua").quickfix()
                            end,
                        },
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
            })
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
        config = function()
            require("keybindings").setup_gitsigns_keybindings()

            require("gitsigns").setup({
                signcolumn = false,
                numhl = false,
                update_debounce = 200,
                preview_config = {
                    border = "none",
                    relative = "cursor",
                    row = 1,
                    col = 0,
                },
            })
        end,
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        event = "VeryLazy",
    },
    {
        "GustavEikaas/easy-dotnet.nvim",
        ft = { "cs", "csx", "vb", "razor" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("easy-dotnet").setup() end,
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup()
            -- Needs to be ran after mason so that executables are in the path
            require("lsp").enable_installed()
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local helpers = require("null-ls.helpers")
            local dotnet_format = {
                method = null_ls.methods.FORMATTING,
                filetypes = { "cs" },
                generator = null_ls.formatter({
                    command = "dotnet",
                    args = { "format", "--include", "$FILENAME" },
                    to_stdin = false,
                }),
            }

            null_ls.setup()

            if vim.fn.executable("gdformat") == 1 then
                null_ls.register({
                    name = "gdformat",
                    method = null_ls.methods.FORMATTING,
                    filetypes = { "gdscript" },
                    generator = null_ls.formatter({
                        command = "gdformat",
                        args = { "$FILENAME" },
                        to_temp_file = true,
                        from_temp_file = true,
                    }),
                })
            end

            if vim.fn.executable("jq") == 1 then
                null_ls.register({
                    name = "jq",
                    method = null_ls.methods.FORMATTING,
                    filetypes = { "json", "jsonc" },
                    generator = helpers.formatter_factory({
                        command = "jq",
                        args = { "--indent", "4", ".", "$FILENAME" },
                        to_temp_file = false,
                        from_temp_file = false,
                        from_stdin = true,
                        to_stdin = true,
                    }),
                })
            end

            if vim.fn.executable("black") == 1 then null_ls.register(null_ls.builtins.formatting.black) end

            if vim.fn.executable("stylua") == 1 then null_ls.register(null_ls.builtins.formatting.stylua) end

            if vim.fn.executable("prettier") == 1 then null_ls.register(null_ls.builtins.formatting.prettier) end

            -- For prebuild configs, check https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
            -- For manual configuing, see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/MAIN.md#sources
        end,
    },
    {
        "jbytes1027/plain-lf.nvim",
        enabled = vim.fn.executable("lf") == 1,
        config = function()
            vim.keymap.set({ "n" }, "<leader>e", function() require("plain-lf").open(true) end, {
                noremap = true,
                desc = "Open explorer",
            })

            require("plain-lf").setup({
                enable_cmds = true,
                replace_netrw = true,
                ---@diagnostic disable-next-line: missing-fields
                ui = {
                    height = 0.95,
                    width = 0.95,
                },
            })
        end,
    },
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        config = function() require("keybindings").setup_smart_splits_keybindings() end,
    },
    {
        "Issafalcon/lsp-overloads.nvim",
        cmd = "LspOverloads",
        opts = {
            ui = {
                border = "none",
                wrap = true,
                wrap_at = nil,
                max_width = nil,
                max_height = nil,
                close_events = {
                    "CursorMoved",
                    "CursorMovedI",
                    "InsertCharPre",
                },
                focusable = true,
                focus = false,
                silent = true,
            },

            keymaps = {
                next_signature = "<C-j>",
                previous_signature = "<C-k>",
                next_parameter = "<C-l>",
                previous_parameter = "<C-h>",
                close_signature = "<A-s>",
            },

            display_automatically = false,
        },
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
            require("keybindings").setup_autocomplete_keybindings()

            require("cmp").setup({
                performance = {
                    debounce = 10,
                    throttle = 0,
                    fetching_timeout = 200,
                    confirm_resolve_timeout = 1,
                    async_budget = 200,
                },
                sources = require("cmp").config.sources({
                    {
                        name = "nvim_lsp",
                        option = {
                            markdown_oxide = {
                                keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
                            },
                        },
                        priority = 1000,
                    },
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
