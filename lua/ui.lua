--- ### AstroNvim UI Options
--
--  Utility functions for easy UI toggles.
--
-- This module can be loaded with `local ui = require("astronvim.utils.ui")`
--
-- @module astronvim.utils.ui
-- @see astronvim.utils
-- @copyright 2022
-- @license GNU General Public License v3.0

local M = {}

local function bool2str(bool) return bool and "on" or "off" end

local function ui_notify(silent, ...) return not silent and vim.notify(...) end

--- Toggle diagnostics
---@param silent? boolean if true then don't sent a notification
function M.toggle_diagnostics(silent)
    if not vim.diagnostic.is_enabled() then
        ui_notify(silent, string.format("diagnostics are disabled"))
        return
    end

    require("lsp").diagnostics_hidden = not require("lsp").diagnostics_hidden
    require("lsp").diagnostics_set_config()

    ui_notify(silent, string.format("diagnostics %s", bool2str(not require("lsp").diagnostics_hidden)))
end

-- Toggle diagnostics severity
-- @param silent? boolean if true then don't sent a notification
function M.toggle_diagnostics_severity(silent)
    if require("lsp").diagnostics_min_severity == vim.diagnostic.severity.WARN then
        require("lsp").diagnostics_min_severity = vim.diagnostic.severity.HINT
    else
        require("lsp").diagnostics_min_severity = vim.diagnostic.severity.WARN
    end

    require("lsp").diagnostics_set_config()

    ui_notify(
        silent,
        string.format(
            "diagnostics severity set to %s",
            vim.diagnostic.severity[require("lsp").diagnostics_min_severity]
        )
    )
end

--- Toggle cmp entrirely
---@param silent? boolean if true then don't sent a notification
function M.toggle_cmp(silent)
    vim.g.cmp_enabled = not vim.g.cmp_enabled
    local ok, _ = pcall(require, "cmp")
    ui_notify(silent, ok and string.format("completion %s", bool2str(vim.g.cmp_enabled)) or "completion not available")
end

--- Toggle buffer semantic token highlighting for all language servers that support it
---@param bufnr? number the buffer to toggle the clients on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_semantic_tokens(bufnr, silent)
    bufnr = bufnr or 0
    vim.b[bufnr].semantic_tokens_enabled = not vim.b[bufnr].semantic_tokens_enabled
    local toggled = false
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
        if client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens[vim.b[bufnr].semantic_tokens_enabled and "start" or "stop"](bufnr, client.id)
            toggled = true
        end
    end
    ui_notify(
        not toggled or silent,
        string.format("Buffer lsp semantic highlighting %s", bool2str(vim.b[bufnr].semantic_tokens_enabled))
    )
end

--- Toggle buffer LSP inlay hints
---@param bufnr? number the buffer to toggle the clients on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_inlay_hints(bufnr, silent)
    bufnr = bufnr or 0
    vim.b[bufnr].inlay_hints_enabled = not vim.b[bufnr].inlay_hints_enabled
    -- TODO: remove check after dropping support for Neovim v0.9
    if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(bufnr, vim.b[bufnr].inlay_hints_enabled)
        ui_notify(silent, string.format("Inlay hints %s", bool2str(vim.b[bufnr].inlay_hints_enabled)))
    end
end

--- Toggle showtabline=2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_tabline(silent)
    vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
    ui_notify(silent, string.format("tabline %s", bool2str(vim.opt.showtabline:get() == 2)))
end

--- Toggle conceal=2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_conceal(silent)
    vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0
    ui_notify(silent, string.format("conceal %s", bool2str(vim.opt.conceallevel:get() == 2)))
end

--- Toggle signcolumn="auto"|"no"
---@param silent? boolean if true then don't sent a notification
function M.toggle_signcolumn(silent)
    if vim.wo.signcolumn == "no" then
        vim.wo.signcolumn = "yes"
    elseif vim.wo.signcolumn == "yes" then
        vim.wo.signcolumn = "auto"
    else
        vim.wo.signcolumn = "no"
    end
    ui_notify(silent, string.format("signcolumn=%s", vim.wo.signcolumn))
end

--- Set the indent and tab related numbers
---@param silent? boolean if true then don't sent a notification
function M.set_indent(silent)
    local input_avail, input = pcall(vim.fn.input, "Set indent value (>0 expandtab, <=0 noexpandtab): ")
    if input_avail then
        local indent = tonumber(input)
        if not indent or indent == 0 then return end
        vim.bo.expandtab = (indent > 0) -- local to buffer
        indent = math.abs(indent)
        vim.bo.tabstop = indent -- local to buffer
        vim.bo.softtabstop = indent -- local to buffer
        vim.bo.shiftwidth = indent -- local to buffer
        ui_notify(silent, string.format("indent=%d %s", indent, vim.bo.expandtab and "expandtab" or "noexpandtab"))
    end
end

--- Change the number display modes
---@param silent? boolean if true then don't sent a notification
function M.change_number(silent)
    local number = vim.wo.number -- local to window
    local relativenumber = vim.wo.relativenumber -- local to window
    if not number and not relativenumber then
        vim.wo.number = true
        vim.wo.relativenumber = true
    else -- not number and relativenumber
        vim.wo.relativenumber = false
        vim.wo.number = false
    end
    ui_notify(
        silent,
        string.format("number %s, relativenumber %s", bool2str(vim.wo.number), bool2str(vim.wo.relativenumber))
    )
end

--- Toggle spell
---@param silent? boolean if true then don't sent a notification
function M.toggle_spell(silent)
    vim.wo.spell = not vim.wo.spell -- local to window
    ui_notify(silent, string.format("spell %s", bool2str(vim.wo.spell)))
end

--- Toggle paste
---@param silent? boolean if true then don't sent a notification
function M.toggle_paste(silent)
    vim.opt.paste = not vim.opt.paste:get() -- local to window
    ui_notify(silent, string.format("paste %s", bool2str(vim.opt.paste:get())))
end

--- Toggle wrap
---@param silent? boolean if true then don't sent a notification
function M.toggle_wrap(silent)
    vim.wo.wrap = not vim.wo.wrap -- local to window
    ui_notify(silent, string.format("wrap %s", bool2str(vim.wo.wrap)))
end

--- Toggle syntax highlighting and treesitter
---@param bufnr? number the buffer to toggle syntax on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_syntax(bufnr, silent)
    -- HACK: this should just be `bufnr = bufnr or 0` but it looks like `vim.treesitter.stop` has a bug with `0` being current
    bufnr = (bufnr and bufnr ~= 0) and bufnr or vim.api.nvim_win_get_buf(0)
    local ts_avail, parsers = pcall(require, "nvim-treesitter.parsers")
    if vim.bo[bufnr].syntax == "off" then
        if ts_avail and parsers.has_parser() then
            vim.treesitter.start(bufnr)
        else
            vim.bo[bufnr].syntax = "on"
        end
        if not vim.b[bufnr].semantic_tokens_enabled then M.toggle_buffer_semantic_tokens(bufnr, true) end
    else
        if ts_avail and parsers.has_parser() then vim.treesitter.stop(bufnr) end
        vim.bo[bufnr].syntax = "off"
        if vim.b[bufnr].semantic_tokens_enabled then M.toggle_buffer_semantic_tokens(bufnr, true) end
    end
    ui_notify(silent, string.format("syntax %s", vim.bo[bufnr].syntax))
end

--- Pretty display for quickfix and location list
--- From github.com/kevinhwang91/nvim-bqf
---@param info table<string, any>
---@return table<string>
function M.quickfixtextfunc(info)
    local ret = {}
    local items

    if info.quickfix == 1 then
        items = vim.fn.getqflist({ id = info.id, items = 0 }).items
    else
        items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    end
    for i = info.start_idx, info.end_idx do
        local curr_item = items[i]
        ---@type string|nil
        local fname = ""
        local str = ""
        if curr_item.valid == 1 then
            if curr_item.bufnr > 0 then
                fname = vim.fn.bufname(curr_item.bufnr)
                if not fname then
                    fname = "[No Name]"
                else
                    fname = fname:gsub("^" .. vim.env.HOME, "~")
                end
            end
            local lnum = curr_item.lnum > 99999 and -1 or curr_item.lnum
            local col = curr_item.col > 999 and -1 or curr_item.col
            print(curr_item.type)
            local qtype = curr_item.type == "" and "" or "" .. curr_item.type:sub(1, 1):upper()

            if qtype ~= "" then
                str = fname .. ":" .. lnum .. ":" .. col .. ":" .. qtype .. ":" .. curr_item.text
            else
                str = fname .. ":" .. lnum .. ":" .. col .. ":" .. curr_item.text
            end
        else
            str = curr_item.text
        end
        table.insert(ret, str)
    end
    return ret
end

local last_active_foldcolumn
--- Toggle foldcolumn=0|1
---@param silent? boolean if true then don't sent a notification
function M.toggle_foldcolumn(silent)
    local curr_foldcolumn = vim.wo.foldcolumn
    if curr_foldcolumn ~= "0" then last_active_foldcolumn = curr_foldcolumn end
    vim.wo.foldcolumn = curr_foldcolumn == "0" and (last_active_foldcolumn or "1") or "0"
    ui_notify(silent, string.format("foldcolumn=%s", vim.wo.foldcolumn))
end

return M
