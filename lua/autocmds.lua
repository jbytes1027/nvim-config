-- highlight all results while searching (not just the next result)
vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    callback = function() vim.o.hlsearch = true end,
})
vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
    callback = function() vim.o.hlsearch = false end,

vim.api.nvim_create_autocmd({ "BufWinEnter" }, { -- highlight text on yank
    callback = function() vim.opt.formatoptions:remove("o") end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, { -- highlight text on yank
    callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 }) end,
})
vim.api.nvim_create_autocmd("LspAttach", { -- disable semantic highlighting
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
vim.api.nvim_create_autocmd({ "FocusGained" }, { -- read shada file when focusing instance
    callback = function() vim.cmd.rshada() end,
})
vim.api.nvim_create_autocmd({ "FocusLost" }, { -- write shada file when unfocusing instance
    callback = function() vim.cmd.wshada() end,
})
