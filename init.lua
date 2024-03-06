if vim.version().minor < 9 then
    print("NVIM 9 or above required to load config")
    return
end

require("options")
require("gruvbox").load()
require("highlights").setup()

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

require("lazy").setup("plugins")

require("cmds") -- load autocommands
require("autocmds") -- load autocommands
require("statusline") -- Setup status bar
require("keybindings").setup() -- load keybindings
