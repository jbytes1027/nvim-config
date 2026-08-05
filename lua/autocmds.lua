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
    command = "syntax off",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.b.lsp_statusline_text = "LSP"
        require("keybindings").set_lsp_keybindings()

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        -- Disable Semantic Tokens Provider
        if client.server_capabilities.semanticTokensProvider ~= nil then
            client.server_capabilities.semanticTokensProvider = nil
        end

        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, {
                ui = {
                    border = "none",
                    wrap = true,
                    wrap_at = nil,
                    max_width = nil,
                    max_height = nil,
                    close_events = {
                        "CursorMoved",
                        "CursorMovedI",
                        "InsertCharPre",
                    },
                    focusable = true,
                    focus = false,
                    silent = true,
                },

                keymaps = {
                    next_signature = "<C-j>",
                    previous_signature = "<C-k>",
                    next_parameter = "<C-l>",
                    previous_parameter = "<C-h>",
                    close_signature = "<A-s>",
                },

                display_automatically = false,
            })

            vim.keymap.set("i", "<C-k>", "<cmd>LspOverloads signature<CR>", {
                buffer = bufnr,
            })
        end
    end,
})

vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(ev)
        local count = #vim.lsp.get_clients({ bufnr = 0 })

        -- If last lsp client
        if count == 1 then vim.b.lsp_statusline_text = "" end
    end,
})
