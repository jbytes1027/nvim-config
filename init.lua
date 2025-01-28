require("options")
require("lsp").diagnostics_set_config() -- disable diagnostics displaying on startup
require("gruvbox").load()
vim.cmd("colorscheme custom")

require("cmds") -- load autocommands
require("autocmds") -- load autocommands
require("commands") -- Load commands
require("statusline") -- Setup status bar
require("keybindings").setup() -- load keybindings

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

require("lazy").setup("plugins", {
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        notify = false, -- get a notification when changes are found
    },

    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "man",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "man",
                "rplugin",
                "shada",
            },
        },
    },
})
