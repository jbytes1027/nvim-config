local M = {}

M.diagnostics_set_config = function()
    local config = {
        signs = false,
        virtual_text = { prefix = "🞙" },
        underline = true,
    }

    if vim.g.diagnostics_hidden then
        config.virtual_text = false
        config.underline = false
    end

    vim.diagnostic.config(config)
end

return M
