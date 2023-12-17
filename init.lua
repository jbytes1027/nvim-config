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
		"williamboman/mason.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
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
        "williamboman/mason.nvim"
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
        }
    }
})

-- SETUP COLORS
require("gruvbox").load()

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
vim.keymap.set("", "<leader>", "") -- disable plane space key
vim.keymap.set({ "i", "c" }, "<C-h>", "<C-w>") -- enable ctrl-backspace
vim.keymap.set({ "i" }, "<C-Del>", "<C-o>dw") -- enable ctrl-delete
vim.keymap.set({ "n" }, "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set({ "n" }, "<leader>fF", function()
	require("telescope.builtin").find_files()({ hidden = true, no_ignore = true })
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

vim.keymap.set({ "n" }, "<leader>e", "<cmd>Explore<CR><CR>", { desc = "Open explorer" })
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
