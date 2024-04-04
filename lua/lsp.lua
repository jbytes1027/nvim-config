local M = {}

M.diagnostics_set_config = function()
    local config = {
        signs = false,
        virtual_text = {
            prefix = "🞙",
            severity = {
                min = vim.diagnostic.severity.WARN,
            },
        },
        underline = {
            severity = {
                min = vim.diagnostic.severity.WARN,
            },
        },
    }

    if vim.g.diagnostics_hidden then
        config.virtual_text = false
        config.underline = false
    end

    vim.diagnostic.config(config)
end

return M
