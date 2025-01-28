local M = {}

M.diagnostics_hidden = true

M.diagnostics_min_severity = vim.diagnostic.severity.WARN;

M.diagnostics_set_config = function()
    local config = {
        signs = false,
        virtual_text = {
            prefix = "🞙",
            severity = {
                min = M.diagnostics_min_severity,
            },
        },
        underline = {
            severity = {
                min = M.diagnostics_min_severity,
            },
        },
    }

    if M.diagnostics_hidden then
        config.virtual_text = false
        config.underline = false
    end

    vim.diagnostic.config(config)
end

return M
