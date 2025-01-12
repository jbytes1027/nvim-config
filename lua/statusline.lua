-- Adapted from https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
function Stl_get_diag()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }
    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local out = {}

    if count["errors"] ~= 0 then table.insert(out, count["errors"] .. "E") end
    if count["warnings"] ~= 0 then table.insert(out, count["warnings"] .. "W") end
    -- if count["hints"] ~= 0 then table.insert(out, count["hints"] .. "H") end
    -- if count["info"] ~= 0 then table.insert(out, count["info"] .. "I") end

    if next(out) == nil then return "" end

    return table.concat(out, ",")
end

Stl_get_git_total_changed = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then return "" end

    local total_changes = 0

    if git_info.added and git_info.added ~= 0 then total_changes = total_changes + git_info.added end
    if git_info.changed and git_info.changed ~= 0 then total_changes = total_changes + git_info.changed end
    if git_info.removed and git_info.removed ~= 0 then total_changes = total_changes + git_info.removed end

    if total_changes ~= 0 then
        return "~" .. total_changes
    else
        return ""
    end
end

Stl_get_git = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then return "" end

    if git_info.added and git_info.added ~= 0 then table.insert(out, "+" .. git_info.added) end
    if git_info.changed and git_info.changed ~= 0 then table.insert(out, "~" .. git_info.changed) end
    if git_info.removed and git_info.removed ~= 0 then table.insert(out, "-" .. git_info.removed) end
    if next(table) == nil then return "" end

    return table.concat(out, ",")
end

Stl_get_readonly = function()
    if vim.bo.readonly then
        return "!"
    else
        return ""
    end
end

Stl_get_modified = function()
    if vim.bo.modified then
        return "*"
    else
        return ""
    end
end

Stl_get_left = function()
    local ret = ""

    local git = Stl_get_git_total_changed()
    if git ~= "" then ret = ret .. "  " .. git end

    local diag = Stl_get_diag()
    if diag ~= "" then ret = ret .. "  " .. diag end

    local lsp = Stl_get_lsp()
    if lsp ~= "" then ret = ret .. "  " .. lsp end

    return ret
end

Stl_get_diff = function()
    if vim.wo.diff then
        return " [diff]"
    else
        return ""
    end
end

Stl_get_recording = function()
    local reg_recording = vim.fn.reg_recording()
    if reg_recording == "" then return "" end

    return "RECORDING @" .. reg_recording .. "  "
end

Stl_get_lsp = function()
    if vim.b.lsp_statusline_text then
        return vim.b.lsp_statusline_text
    else
        return ""
    end
end

Stl_get_search = function()
    local search_status = vim.fn.searchcount()
    if not vim.o.hlsearch then return "" end

    local current_match = search_status.current
    if current_match > 99 then current_match = ">99" end

    local total_match = search_status.total
    if total_match > 99 then total_match = ">99" end

    return "Match " .. current_match .. "/" .. total_match .. "  "
end

vim.o.statusline = table.concat({
    "%t", -- file title
    "%{v:lua.Stl_get_modified()}",
    "%{v:lua.Stl_get_readonly()}",
    "%{v:lua.Stl_get_diff()}",
    "%<", -- when squeezed, cut off everything after
    "%{v:lua.Stl_get_left()}",
    "%=", -- right align following
    '%{&fileformat}',
    -- '%{&fenc==""?&enc:&fenc}', -- file encoding, otherwise encoding
    "  %l:%c", -- line:col
    "  %P", -- percentage in file by line
})
