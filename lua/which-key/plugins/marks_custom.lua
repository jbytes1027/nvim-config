-- See which-key repo for plugin examples
local M = {}

M.name = "marks_custom"

M.mappings = {
    icon = { icon = "󰸕 ", color = "orange" },
    plugin = "marks_custom",
    { "`", desc = "common marks" },
    { "'", desc = "common marks" },
    { "g`", desc = "common marks" },
    { "g'", desc = "common marks" },
    { "m", desc = "common marks" },
}

function M.expand()
    local buf = vim.api.nvim_get_current_buf()

    local marks = {} ---@type vim.fn.getmarklist.ret.item[]
    -- vim.list_extend(marks, vim.fn.getmarklist(buf))
    vim.list_extend(marks, vim.fn.getmarklist())

    local mark_desc_pairs = {}

    for _, mark in pairs(marks) do
        local key = mark.mark:sub(2, 2)
        local lnum = mark.pos[2]

        if mark.file then
            mark_desc_pairs[key] = vim.fn.fnamemodify(mark.file, ":t")
        else
            mark_desc_pairs[key] = " "
        end
    end

    local items = {} ---@type wk.Plugin.item[]

    table.insert(items, { key = "A", desc = mark_desc_pairs["A"] })
    table.insert(items, { key = "S", desc = mark_desc_pairs["S"] })
    table.insert(items, { key = "D", desc = mark_desc_pairs["D"] })
    table.insert(items, { key = "F", desc = mark_desc_pairs["F"] })
    table.insert(items, { key = "G", desc = mark_desc_pairs["G"] })
    table.insert(items, { key = "H", desc = mark_desc_pairs["H"] })
    table.insert(items, { key = "J", desc = mark_desc_pairs["J"] })
    table.insert(items, { key = "K", desc = mark_desc_pairs["K"] })
    table.insert(items, { key = "K", desc = mark_desc_pairs["K"] })
    table.insert(items, { key = "L", desc = mark_desc_pairs["L"] })

    return items
end

return M
