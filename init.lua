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
vim.opt.shiftwidth = 0  -- use tabstop value for shift operations
vim.opt.clipboard = 'unnamedplus' -- use sytem clipboard
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
    -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    }
})

-- SETUP COLORS
require("gruvbox").load()

require'nvim-treesitter.configs'.setup {
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
}

-- CUSTOM COMMANDS
-- vim.api.nvim_exec([[ 
--   augroup vimrc-incsearch-highlight
--     autocmd!
--     autocmd CmdlineEnter /,\? lua vim.o.hlsearch = true
--     autocmd CmdlineLeave /,\? lua vim.o.hlsearch = false
--   augroup END
-- ]], false)

-- highlight all results while searching (not just the next result)
vim.api.nvim_create_autocmd({"CmdlineEnter"}, { callback = function() vim.o.hlsearch = true end }) 
vim.api.nvim_create_autocmd({"CmdlineLeave"}, { callback = function() vim.o.hlsearch = false end })

-- CUSTOM KEYMAPS
vim.g.mapleader = ' '
vim.keymap.set('', '<Space>', '') -- disable plane space key
vim.keymap.set({'i', 'c'}, '<C-h>', '<C-w>') -- enable ctrl-backspace
vim.keymap.set({'i'}, '<C-Del>', '<C-o>dw') -- enable ctrl-delete

