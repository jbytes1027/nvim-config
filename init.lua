vim.g.mapleader = " "
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.o.exrc = true -- load cd configs
vim.opt.hidden = true -- allow hidden buffers
vim.opt.mouse = "a" -- enable mouse for all modes
vim.opt.laststatus = 2 -- hide status bar
vim.opt.cmdheight = 0 -- hide bottom command bar
vim.opt.hls = false -- disable persistant search highlighting
vim.opt.incsearch = true -- highlight search results while typing
vim.opt.breakindent = true -- wraped lines have the same intent level
vim.opt.linebreak = true -- wrap lines at 'breakat'
vim.opt.relativenumber = true -- relateive line numbers
vim.opt.number = true -- fixed line numbers
vim.opt.tabstop = 4 -- tab is 4 spaces
vim.opt.expandtab = true -- convert <tab> to spaces
vim.opt.shiftwidth = 0 -- use tabstop value for shift operations
vim.opt.clipboard = "unnamedplus" -- use sytem clipboard
vim.opt.ignorecase = true -- ignore case by default when searching
vim.opt.jumpoptions = "view"
vim.o.diffopt = "internal,filler,closeoff,algorithm:patience,linematch:60"
vim.o.completeopt = "menu,menuone,noselect"
vim.lsp.set_log_level(vim.log.levels.INFO)

-- Config vindent keybindings
vim.g.vindent_motion_OO_prev   = '[i' -- jump to prev block of same indent.
vim.g.vindent_motion_OO_next   = ']i' -- jump to next block of same indent.
vim.g.vindent_motion_more_prev = '[+' -- jump to prev line with more indent.
vim.g.vindent_motion_more_next = ']+' -- jump to next line with more indent.
vim.g.vindent_motion_less_prev = '[-' -- jump to prev line with less indent.
vim.g.vindent_motion_less_next = ']-' -- jump to next line with less indent.
vim.g.vindent_motion_diff_prev = '[;' -- jump to prev line with different indent.
vim.g.vindent_motion_diff_next = '];' -- jump to next line with different indent.
vim.g.vindent_motion_XX_ss     = '[p' -- jump to start of the current block scope.
vim.g.vindent_motion_XX_se     = ']p' -- jump to end   of the current block scope.
vim.g.vindent_object_XX_ii     = 'ii' -- select current block.
vim.g.vindent_object_XX_ai     = 'ai' -- select current block + one extra line  at beginning.
vim.g.vindent_object_XX_aI     = 'aI' -- select current block + two extra lines at beginning and end.
vim.g.vindent_jumps            = 1    -- make vindent motion count as a |jump-motion| (works with |jumplist|).

require("lsp").diagnostics_set_config()

-- SETUP COLORS
require("gruvbox").load()

-- SETUP LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then -- install lazyvim if not found in lazypath
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- GET PLUGINS
require("lazy").setup({
    {
        "tommcdo/vim-ninja-feet"
    },
    {
        "jessekelighine/vindent.vim"
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
        opts = {
            -- See https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
            motions = {
                count = false,
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
            numhl = true,
            update_debounce = 200,
        },
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
                    dotnet_format,
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
            },
        },
    },
    {
        "numToStr/Comment.nvim",
    },
    {
        enabled = jit.os ~= "Windows",
        "kelly-lin/ranger.nvim",
        config = function() require("ranger-nvim").setup({ replace_netrw = true }) end,
    },
    {
        "mrjones2014/smart-splits.nvim",
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                names = false,
                rgb_fn = true,
                hsl_fn = true,
                mode = "virtualtext",
                virtualtext = "███",
            },
        },
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
                    debounce = 60,
                    throttle = 30,
                    fetching_timeout = 100,
                    confirm_resolve_timeout = 1,
                    async_budget = 1,
                    max_view_entries = 20,
                },
                sources = require("cmp").config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    -- { name = "luasnip",  priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                    { name = "nvim_lsp_signature_help" },
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
            })
        end,
    },
})

require("autocmds") -- load autocommands
require("statusline") -- Setup status bar
require("keybindings") -- load keybindings
