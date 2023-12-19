vim.o.exrc = true                 -- load cd configs
vim.opt.hidden = true             -- allow hidden buffers
vim.opt.mouse = "a"               -- enable mouse for all modes
vim.opt.laststatus = 2            -- hide status bar
vim.opt.cmdheight = 0             -- hide bottom command bar
vim.opt.hls = false               -- disable persistant search highlighting
vim.opt.incsearch = true          -- highlight search results while typing
vim.opt.breakindent = true        -- wraped lines have the same intent level
vim.opt.linebreak = true          -- wrap lines at 'breakat'
vim.opt.relativenumber = true     -- relateive line numbers
vim.opt.number = true             -- fixed line numbers
vim.opt.tabstop = 4               -- tab is 4 spaces
vim.opt.expandtab = true          -- convert <tab> to spaces
vim.opt.shiftwidth = 0            -- use tabstop value for shift operations
vim.opt.clipboard = "unnamedplus" -- use sytem clipboard
vim.opt.ignorecase = true         -- ignore case by default when searching
vim.o.diffopt = "internal,filler,closeoff,algorithm:patience"

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
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "williamboman/mason.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                cmd = { "NullLsInstall", "NullLsUninstall" },
                opts = { handlers = {} },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        dependencies = {
            {
                "williamboman/mason.nvim",
            },
            {
                "neovim/nvim-lspconfig",
            },
        },
    },
    {
        "j-hui/fidget.nvim",
    },
    {
        "numToStr/Comment.nvim",
    },
    {
        "kelly-lin/ranger.nvim",
        config = function()
            require("ranger-nvim").setup({ replace_netrw = true })
        end,
    },
    {
        "mrjones2014/smart-splits.nvim",
    },
})

require("Comment").setup()

require("fidget").setup({
    notification = {
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
    },
})

vim.lsp.set_log_level(vim.log.levels.WARN)

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
        disable = function(lang, buf)
            local max_filesize = 1000 * 1024 -- 1000 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
})

require("telescope").setup({ -- see https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
    defaults = {
        sorting_strategy = "ascending",
        path_display = { "truncate" },
        layout_config = {
            horizontal = { prompt_position = "top" },
        },
        mappings = {
            i = {
                ["<esc>"] = require("telescope.actions").close,
                ["<C-h>"] = function()
                    vim.api.nvim_input("<C-w>")
                end, -- enable ctrl-backspace
            },
        },
    },
})

require("mason").setup()
require("mason-null-ls").setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,
    handlers = {},
})
require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    },
})
require("gitsigns").setup({
    signcolumn = false,
    numhl = true,
    update_debounce = 0,
})
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler and will be called for each installed server that doesn't have a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({})
    end,
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = false, -- Disable signs
})
-- from https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
function Stl_get_diag()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }
    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local out = {}

    if count["errors"] ~= 0 then
        table.insert(out, count["errors"] .. "E")
    end
    if count["warnings"] ~= 0 then
        table.insert(out, count["warnings"] .. "W")
    end
    if count["hints"] ~= 0 then
        table.insert(out, count["hints"] .. "H")
    end
    if count["info"] ~= 0 then
        table.insert(out, count["info"] .. "I")
    end

    if next(out) == nil then
        return ""
    end

    return table.concat(out, ",")
end

Stl_get_git = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end

    local out = {}

    if git_info.added and git_info.added ~= 0 then
        table.insert(out, "+" .. git_info.added)
    end
    if git_info.changed and git_info.changed ~= 0 then
        table.insert(out, "~" .. git_info.changed)
    end
    if git_info.removed and git_info.removed ~= 0 then
        table.insert(out, "-" .. git_info.removed)
    end
    if next(table) == nil then
        return ""
    end

    return table.concat(out, ",")
end

Stl_get_readonly = function()
    if vim.bo.readonly then
        return "!"
    else
        return ""
    end
end

Stl_get_modified = function()
    if vim.bo.modified then
        return "*"
    else
        return ""
    end
end

Stl_get_left = function()
    local ret = ""

    local git = Stl_get_git()
    if git ~= "" then
        ret = ret .. "  " .. git
    end

    local diag = Stl_get_diag()
    if diag ~= "" then
        ret = ret .. "  " .. diag
    end

    return ret
end

Stl_get_recording = function()
    local reg_recording = vim.fn.reg_recording()
    if reg_recording == "" then
        return ""
    end

    return "RECORDING @" .. reg_recording .. "  "
end

-- setup status bar
local statusline = "%t" -- file title
statusline = statusline .. "%{v:lua.Stl_get_modified()}"
statusline = statusline .. "%{v:lua.Stl_get_readonly()}"
statusline = statusline .. "%<"
statusline = statusline .. "%{v:lua.Stl_get_left()}"
statusline = statusline .. "%="                      -- right align following
statusline = statusline .. "%{v:lua.Stl_get_recording()}"
statusline = statusline .. '%{&fenc==""?&enc:&fenc}' -- file encoding, otherwise encoding
statusline = statusline .. "  %l:%c"                 -- line:col
statusline = statusline .. "  %P"                    -- percentage in file by line
vim.o.statusline = statusline

-- highlight all results while searching (not just the next result)
vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    callback = function()
        vim.o.hlsearch = true
    end,
})
vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
    callback = function()
        vim.o.hlsearch = false
    end,
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
}) -- auto highlight

-- CUSTOM KEYMAPS
vim.g.mapleader = " "
vim.keymap.set("", "<leader>", "")             -- disable plane space key
vim.keymap.set({ "i", "c" }, "<C-h>", "<C-w>") -- enable ctrl-backspace
vim.keymap.set({ "i" }, "<C-Del>", "<C-o>dw")  -- enable ctrl-delete
vim.keymap.set({ "n" }, "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set({ "n" }, "<leader>fF", function()
    require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Find all files" })
vim.keymap.set({ "n" }, "<leader>fk", function()
    require("telescope.builtin").keymaps()
end, { desc = "Find keymaps" })
vim.keymap.set({ "n" }, "<leader>fm", function()
    require("telescope.builtin").man_pages()
end, { desc = "Find man pages" })
vim.keymap.set({ "n" }, "<leader>fb", function()
    require("telescope.builtin").buffers()
end, { desc = "Find buffers" })
vim.keymap.set({ "n" }, "<leader>fc", function()
    require("telescope.builtin").grep_string()
end, { desc = "Find word under cursor" })
vim.keymap.set({ "n" }, "<leader>fC", function()
    require("telescope.builtin").commands()
end, { desc = "Find commands" })
vim.keymap.set({ "n" }, "<leader>fh", function()
    require("telescope.builtin").help_tags()
end, { desc = "Find help" })
vim.keymap.set({ "n" }, "<leader>fo", function()
    require("telescope.builtin").oldfiles()
end, { desc = "Find history" })
vim.keymap.set({ "n" }, "<leader>fr", function()
    require("telescope.builtin").registers()
end, { desc = "Find registers" })
vim.keymap.set({ "n" }, "<leader>fw", function()
    require("telescope.builtin").live_grep()
end, { desc = "Find words" })
vim.keymap.set({ "n" }, "<leader>fl", function()
    require("telescope.builtin").resume()
end, { desc = "Resume last search" })
vim.keymap.set({ "n" }, "<leader>fW", function()
    require("telescope.builtin").live_grep({
        additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
    })
end, { desc = "Find words in all files" })
vim.keymap.set({ "n" }, "<leader>ls", function()
    local aerial_avail, _ = pcall(require, "aerial")
    if aerial_avail then
        require("telescope").extensions.aerial.aerial()
    else
        require("telescope.builtin").lsp_document_symbols()
    end
end, { desc = "Search symbols" })

vim.keymap.set({ "n" }, "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
vim.keymap.set({ "n" }, "<leader>lI", "<cmd>NullLsInfo<cr>", { desc = "Null-ls information" })
vim.keymap.set({ "n" }, "<leader>la", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
vim.keymap.set({ "v" }, "<leader>la", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
vim.keymap.set({ "n" }, "gd", function()
    vim.lsp.buf.definition()
end, { desc = "Show the definition of current symbol" })
vim.keymap.set({ "n" }, "gD", function()
    vim.lsp.buf.declaration()
end, { desc = "Declaration of current symbol" })
vim.keymap.set({ "n" }, "gI", function()
    vim.lsp.buf.implementation()
end, { desc = "Implementation of current symbol" })
vim.keymap.set({ "n" }, "<leader>lf", function()
    vim.lsp.buf.format()
end, { desc = "Format buffer" })
vim.keymap.set({ "v" }, "<leader>lf", function()
    vim.lsp.buf.format()
end, { desc = "Format buffer" })
vim.keymap.set({ "n" }, "gr", function()
    vim.lsp.buf.references()
end, { desc = "References of current symbol" })
vim.keymap.set({ "n" }, "<leader>lR", function()
    vim.lsp.buf.references()
end, { desc = "Search references" })
vim.keymap.set({ "n" }, "<leader>lr", function()
    vim.lsp.buf.rename()
end, { desc = "Rename current symbol" })
vim.keymap.set({ "n" }, "<leader>lh", function()
    vim.lsp.buf.signature_help()
end, { desc = "Signature help" })
vim.keymap.set({ "n" }, "gy", function()
    vim.lsp.buf.type_definition()
end, { desc = "Definition of current type" })
vim.keymap.set({ "n" }, "<leader>e", "", {
    callback = function()
        require("ranger-nvim").open(true)
    end,
    noremap = true,
    desc = "Open explorer",
})
vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", {
    desc = "Toggle comment for selection",
})
vim.keymap.set({ "n" }, "<leader>n", "<cmd>enew<cr>", { desc = "New file" })
vim.keymap.set({ "n" }, "<A-w>", "<cmd>close<cr>", { desc = "Close window" })
vim.keymap.set({ "n" }, "<A-|>", "<cmd>split<cr><C-w>j", { desc = "Horizontal Split" })
vim.keymap.set({ "n" }, "<A-\\>", "<cmd>vsplit<cr><C-w>l", { desc = "Vertical Split" })
vim.keymap.set({ "n" }, "<A-h>", "<cmd>wincmd h<cr>", { desc = "Left window navigation" })
vim.keymap.set({ "n" }, "<A-j>", "<cmd>wincmd j<cr>", { desc = "Down window navigation" })
vim.keymap.set({ "n" }, "<A-k>", "<cmd>wincmd k<cr>", { desc = "Up window navigation" })
vim.keymap.set({ "n" }, "<A-l>", "<cmd>wincmd l<cr>", { desc = "Right window navigation" })
vim.keymap.set({ "n" }, "<A-S-h>", function()
    require("smart-splits").swap_buf_left({ move_cursor = true })
end, { desc = "Window move left" })
vim.keymap.set({ "n" }, "<A-S-j>", function()
    require("smart-splits").swap_buf_down({ move_cursor = true })
end, { desc = "Window move down" })
vim.keymap.set({ "n" }, "<A-S-k>", function()
    require("smart-splits").swap_buf_up({ move_cursor = true })
end, { desc = "Window move up" })
vim.keymap.set({ "n" }, "<A-S-l>", function()
    require("smart-splits").swap_buf_right({ move_cursor = true })
end, { desc = "Window move right" })
vim.keymap.set({ "n" }, "<C-h>", require("smart-splits").resize_left, { desc = "Resize split right" })
vim.keymap.set({ "n" }, "<C-j>", require("smart-splits").resize_down, { desc = "Resize split down" })
vim.keymap.set({ "n" }, "<C-k>", require("smart-splits").resize_up, { desc = "Resize split up" })
vim.keymap.set({ "n" }, "<C-l>", require("smart-splits").resize_right, { desc = "Resize split left" })
vim.keymap.set({ "n" }, "<C-l>", require("smart-splits").resize_right, { desc = "Resize split left" })
