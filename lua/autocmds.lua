vim.on_key(
    function(char) -- highlight search when using from https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0/
        if vim.fn.mode() == "n" then
            local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
            if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
        end
    end,
    vim.api.nvim_create_namespace("auto_hlsearch")
)

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
