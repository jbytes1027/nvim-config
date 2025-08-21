-- vim.on_key(
--     function(char) -- highlight search when using from https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0/
--         if vim.fn.mode() == "n" then
--             local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
--             if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
--         end
--     end,
--     vim.api.nvim_create_namespace("auto_hlsearch")
-- )

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    -- See https://github.com/L3MON4D3/LuaSnip/issues/258
    callback = function() require("luasnip").unlink_current() end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, { -- highlight text on yank
    callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 }) end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.cshtml", "*.razor" },
    command = "setf razor | set syntax=razor",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.min.*",
    command = "TSDisable highlight | syntax off",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.b.lsp_statusline_text = "LSP"
        require("keybindings").set_lsp_keybindings()
    end,
})

vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(ev)
        local count = #vim.lsp.get_clients({ bufnr = 0 })

        -- If last lsp client
        if count == 1 then vim.b.lsp_statusline_text = "" end
    end,
})
