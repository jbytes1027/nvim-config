-- file must be loaded before keybindings because of mapleader

vim.g.mapleader = " "
vim.opt.wrap = false
vim.opt.scrolloff = 1
vim.o.exrc = true -- load cd configs
vim.opt.hidden = true -- allow hidden buffers
vim.opt.mouse = "a" -- enable mouse for all modes
vim.opt.laststatus = 2 -- always show status bar
vim.opt.hlsearch = true
vim.opt.incsearch = true -- highlight search results while typing
vim.opt.breakindent = true -- wraped lines have the same intent level
vim.opt.linebreak = true -- wrap lines at 'breakat'
vim.opt.relativenumber = true -- relateive line numbers
vim.opt.number = true -- fixed line numbers
vim.opt.smartcase = true -- fixed line numbers
vim.opt.tabstop = 4 -- tab is 4 spaces
vim.opt.expandtab = true -- convert <tab> to spaces
vim.opt.shiftwidth = 0 -- use tabstop value for shift operations
vim.o.clipboard = "unnamed,unnamedplus" -- use +, *, and " registers for copying
vim.opt.ignorecase = true -- ignore case by default when searching
vim.opt.jumpoptions = "view" -- restore view when jumping
vim.o.diffopt = "internal,filler,closeoff,algorithm:patience,linematch:60,hiddenoff"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.pumheight = 20
vim.o.listchars = "space:⋅,tab:→ ,eol:↴,nbsp:␣"
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.ruler = false -- for hiding ruler in cmdline for popup windows
vim.opt.foldignore = ""
-- vim.opt.foldtext = ""
vim.o.shortmess = "aoOtTIs"
vim.o.smoothscroll = true
vim.o.confirm = true

-- remove the "How-to disable mouse" menu item and the separator above it: >vim
vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
vim.cmd("aunmenu PopUp.-1-")

require("ui").set_diagnostics(false) -- disable diagnostics displaying on startup
