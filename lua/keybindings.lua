local function feedkeys(keys, mode)
    local replaced_key = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(replaced_key, mode, true)
end

local M = {}

M.set_searching_keybindings = function()
    vim.keymap.set(
        { "n" },
        "<leader>ff",
        function() require("telescope.builtin").find_files() end,
        { desc = "Find files" }
    )
    vim.keymap.set({ "n" }, "<A-f>", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
    vim.keymap.set(
        { "n" },
        "<leader>fF",
        function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
        { desc = "Find all files" }
    )
    vim.keymap.set(
        { "n" },
        "<A-F>",
        function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
        { desc = "Find all files" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fd",
        function()
            require("telescope.builtin").diagnostics({ bufnr = 0, severity_limit = vim.diagnostic.severity.WARN })
        end,
        { desc = "Find buffer diagnostics" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fD",
        function()
            require("telescope.builtin").diagnostics({ root_dir = true, severity_limit = vim.diagnostic.severity.WARN })
        end,
        { desc = "Find all diagnostics" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fs",
        function() require("telescope.builtin").lsp_document_symbols() end,
        { desc = "Find buffer symbols" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fS",
        function() require("telescope.builtin").lsp_workspace_symbols() end,
        { desc = "Find workspace symbols" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fk",
        function() require("telescope.builtin").keymaps() end,
        { desc = "Find keymaps" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fm",
        function() require("telescope.builtin").marks() end,
        { desc = "Find man pages" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fb",
        function() require("telescope.builtin").buffers() end,
        { desc = "Find buffers" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fc",
        function() require("telescope.builtin").grep_string() end,
        { desc = "Find word under cursor" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fC",
        function() require("telescope.builtin").commands() end,
        { desc = "Find commands" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fh",
        function() require("telescope.builtin").help_tags() end,
        { desc = "Find help" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fo",
        function() require("telescope.builtin").oldfiles() end,
        { desc = "Find history" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fr",
        function() require("telescope.builtin").registers() end,
        { desc = "Find registers" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fw",
        function() require("telescope.builtin").live_grep() end,
        { desc = "Find words" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>fl",
        function() require("telescope.builtin").resume() end,
        { desc = "Resume last search" }
    )
    vim.keymap.set({ "n" }, "<leader>fW", function()
        require("telescope.builtin").live_grep({
            additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
        })
    end, { desc = "Find words in all files" })
    vim.keymap.set({ "n" }, "<leader>ls", function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
            require("telescope").extensions.aerial.aerial()
        else
            require("telescope.builtin").lsp_document_symbols()
        end
    end, { desc = "Search symbols" })
end

M.set_lsp_keybindings = function()
    local buff_has_lsp = function() return next(vim.lsp.get_active_clients({ bufnr = 0 })) ~= nil end

    vim.keymap.set({ "n" }, "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
    vim.keymap.set({ "n" }, "<leader>lI", "<cmd>NullLsInfo<cr>", { desc = "Null-ls information" })
    vim.keymap.set({ "i" }, "<C-k>", function() vim.lsp.buf.signature_help() end, { desc = "Show signature" })
    vim.keymap.set({ "n", "x" }, "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "LSP code action" })
    vim.keymap.set({ "n", "x" }, "gd", function()
        if buff_has_lsp() then
            vim.lsp.buf.definition()
        else
            feedkeys("gd", "n")
        end
    end, { desc = "Show the definition of current symbol" })
    vim.keymap.set({ "n", "x" }, "gD", function()
        if buff_has_lsp() then
            vim.lsp.buf.declaration()
        else
            feedkeys("gD", "n")
        end
    end, { desc = "Declaration of current symbol" })
    vim.keymap.set(
        { "n" },
        "gI",
        function() vim.lsp.buf.implementation() end,
        { desc = "Implementation of current symbol" }
    )
    vim.keymap.set({ "n" }, "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format buffer" })
    vim.keymap.set({ "x" }, "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format selection" })
    vim.keymap.set({ "n" }, "<leader>lc", function() vim.lsp.buf.incoming_calls() end, { desc = "View incoming calls" })
    vim.keymap.set({ "n" }, "<leader>lC", function() vim.lsp.buf.outgoing_calls() end, { desc = "View outgoing calls" })
    vim.keymap.set({ "n" }, "gr", function() vim.lsp.buf.references() end, { desc = "References of current symbol" })
    vim.keymap.set({ "n" }, "<leader>lR", function() vim.lsp.buf.references() end, { desc = "Search references" })
    vim.keymap.set({ "n" }, "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename current symbol" })
    vim.keymap.set({ "n" }, "<leader>lh", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
    vim.keymap.set({ "n" }, "<leader>ll", vim.lsp.codelens.refresh, { desc = "LSP CodeLens refresh" })
    vim.keymap.set({ "n", "x" }, "<leader>lL", vim.lsp.codelens.run, { desc = "LSP CodeLens run" })
    vim.keymap.set({ "n" }, "gy", function() vim.lsp.buf.type_definition() end, { desc = "Definition of current type" })
    vim.keymap.set({ "n" }, "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "Hover diagnostics" })
    vim.keymap.set(
        { "n" },
        "[d",
        function() vim.diagnostic.goto_prev({ float = true, severity = { min = vim.diagnostic.severity.WARN } }) end,
        { desc = "Previous diagnostic" }
    )
    vim.keymap.set(
        { "n" },
        "]d",
        function() vim.diagnostic.goto_next({ float = true, severity = { min = vim.diagnostic.severity.WARN } }) end,
        { desc = "Next diagnostic" }
    )
end

M.set_window_and_buffer_keybindings = function()
    -- Buffer
    vim.keymap.set({ "n" }, "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
    vim.keymap.set({ "n" }, "]B", "<cmd>blast<cr>", { desc = "Last buffer" })
    vim.keymap.set({ "n" }, "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
    vim.keymap.set({ "n" }, "[B", "<cmd>bfirst<cr>", { desc = "First buffer" })
    -- Window
    vim.keymap.set({ "n" }, "<leader>w", "<cmd>close<cr>", { desc = "Close window" })
    vim.keymap.set({ "n" }, "<A-w>", "<cmd>close<cr>", { desc = "Close window" })
    vim.keymap.set({ "n" }, "<A-|>", "<cmd>split<cr><C-w>j", { desc = "Horizontal Split" })
    vim.keymap.set({ "n" }, "<A-\\>", "<cmd>vsplit<cr><C-w>l", { desc = "Vertical Split" })
    vim.keymap.set({ "n" }, "<A-h>", "<cmd>wincmd h<cr>", { desc = "Left window navigation" })
    vim.keymap.set({ "n" }, "<A-j>", "<cmd>wincmd j<cr>", { desc = "Down window navigation" })
    vim.keymap.set({ "n" }, "<A-k>", "<cmd>wincmd k<cr>", { desc = "Up window navigation" })
    vim.keymap.set({ "n" }, "<A-l>", "<cmd>wincmd l<cr>", { desc = "Right window navigation" })
    vim.keymap.set(
        { "n" },
        "<A-S-h>",
        function() require("smart-splits").swap_buf_left({ move_cursor = true }) end,
        { desc = "Window move left" }
    )
    vim.keymap.set(
        { "n" },
        "<A-S-j>",
        function() require("smart-splits").swap_buf_down({ move_cursor = true }) end,
        { desc = "Window move down" }
    )
    vim.keymap.set(
        { "n" },
        "<A-S-k>",
        function() require("smart-splits").swap_buf_up({ move_cursor = true }) end,
        { desc = "Window move up" }
    )
    vim.keymap.set(
        { "n" },
        "<A-S-l>",
        function() require("smart-splits").swap_buf_right({ move_cursor = true }) end,
        { desc = "Window move right" }
    )
    vim.keymap.set({ "n" }, "<C-h>", require("smart-splits").resize_left, { desc = "Resize split right" })
    vim.keymap.set({ "n" }, "<C-j>", require("smart-splits").resize_down, { desc = "Resize split down" })
    vim.keymap.set({ "n" }, "<C-k>", require("smart-splits").resize_up, { desc = "Resize split up" })
    vim.keymap.set({ "n" }, "<C-l>", require("smart-splits").resize_right, { desc = "Resize split left" })
    vim.keymap.set({ "n" }, "<C-l>", require("smart-splits").resize_right, { desc = "Resize split left" })
end

M.set_git_keybindings = function()
    vim.keymap.set({ "n" }, "]c", function()
        if vim.wo.diff then
            vim.cmd("normal! ]c")
        else
            vim.schedule(function() require("gitsigns").next_hunk({ preview = false }) end)
        end
    end, { desc = "Jump to next hunk" })
    vim.keymap.set({ "n" }, "[c", function()
        if vim.wo.diff then
            vim.cmd("normal! [c")
        else
            vim.schedule(function() require("gitsigns").prev_hunk({ preview = false }) end)
        end
    end, { desc = "Jump to prev hunk" })

    vim.keymap.set({ "n" }, "<leader>gb", function() require("gitsigns").blame_line() end, { desc = "View git blame" })
    vim.keymap.set(
        { "n" },
        "<leader>gB",
        function() require("gitsigns").blame_line({ full = true }) end,
        { desc = "View full git blame" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>gp",
        function() require("gitsigns").preview_hunk() end,
        { desc = "Preview git hunk" }
    )
    vim.keymap.set({ "n" }, "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Git hunk" })
    vim.keymap.set(
        { "x" },
        "<leader>gr",
        function()
            require("gitsigns").reset_hunk({
                vim.api.nvim_buf_get_mark(0, "<")[1],
                vim.api.nvim_buf_get_mark(0, ">")[1],
            })
        end,
        { desc = "Reset Git hunk" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>gR",
        function() require("gitsigns").reset_buffer() end,
        { desc = "Reset Git buffer" }
    )
    vim.keymap.set({ "n" }, "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Git hunk" })
    vim.keymap.set(
        { "x" },
        "<leader>gs",
        function()
            require("gitsigns").stage_hunk({
                vim.api.nvim_buf_get_mark(0, "<")[1],
                vim.api.nvim_buf_get_mark(0, ">")[1],
            })
        end,
        { desc = "Stage Git hunk" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>gS",
        function() require("gitsigns").stage_buffer() end,
        { desc = "Stage Git buffer" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>gu",
        function() require("gitsigns").undo_stage_hunk() end,
        { desc = "Undo Git stage" }
    )
    vim.keymap.set(
        { "n" },
        "<leader>gU",
        function() require("gitsigns").reset_buffer_index() end,
        { desc = "Unstage Git file" }
    )
    vim.keymap.set({ "n" }, "<leader>gd", function() require("gitsigns").diffthis() end, { desc = "View Git diff" })
end

M.set_toggle_keybindings = function()
    vim.keymap.set({ "n" }, "<leader>ud", require("ui").toggle_diagnostics, { desc = "Toggle diagnostics" })
    vim.keymap.set({ "n" }, "<leader>ug", require("ui").toggle_signcolumn, { desc = "Toggle signcolumn" })
    vim.keymap.set({ "n" }, "<leader>ui", require("ui").set_indent, { desc = "Change indent setting" })
    vim.keymap.set({ "n" }, "<leader>un", require("ui").change_number, { desc = "Change line numbering" })
    vim.keymap.set({ "n" }, "<leader>up", require("ui").toggle_paste, { desc = "Toggle paste mode" })
    vim.keymap.set({ "n" }, "<leader>us", require("ui").toggle_spell, { desc = "Toggle spellcheck" })
    vim.keymap.set({ "n" }, "<leader>uc", require("ui").toggle_conceal, { desc = "Toggle conceal" })
    vim.keymap.set({ "n" }, "<leader>ut", require("ui").toggle_tabline, { desc = "Toggle tabline" })
    vim.keymap.set({ "n" }, "<leader>uw", require("ui").toggle_wrap, { desc = "Toggle wrap" })
    vim.keymap.set({ "n" }, "<leader>ul", "<cmd>set list!<cr>", { desc = "Toggle whitespace" })
    vim.keymap.set(
        { "n" },
        "<leader>uy",
        require("ui").toggle_buffer_syntax,
        { desc = "Toggle syntax highlighting (buffer)" }
    )
    vim.keymap.set({ "n" }, "<leader>uf", require("ui").toggle_foldcolumn, { desc = "Toggle foldcolumn" })
end

M.set_autocomplete_keybindings = function()
    local ls = require("luasnip")
    local cmp = require("cmp")
    vim.keymap.set("i", "<C-Space>", function()
        if cmp.visible() == false then
            cmp.complete()
        else
            cmp.close()
        end
    end)
    vim.keymap.set("i", "<C-p>", function()
        if cmp.visible() == false then cmp.complete() end
        cmp.select_prev_item()
    end)
    vim.keymap.set("i", "<C-n>", function()
        if cmp.visible() == false then cmp.complete() end
        cmp.select_next_item()
    end)
    vim.keymap.set("i", "<C-f>", function()
        if cmp.visible() == true then
            cmp.select_next_item({ count = vim.o.pumheight })
        else
            feedkeys("<C-f>", "n")
        end
    end)
    vim.keymap.set("i", "<C-b>", function()
        if cmp.visible() == true then
            cmp.select_prev_item({ count = vim.o.pumheight })
        else
            feedkeys("<C-b>", "n")
        end
    end)
    vim.keymap.set("i", "<C-u>", function()
        if cmp.visible() == true then
            cmp.scroll_docs(-4)
        else
            feedkeys("<C-u>", "n")
        end
    end)
    vim.keymap.set("i", "<C-d>", function()
        if cmp.visible() == true then
            cmp.scroll_docs(4)
        else
            feedkeys("<C-d>", "n")
        end
    end)
    vim.keymap.set("i", "<C-y>", function()
        if cmp.visible() == true then
            cmp.confirm()
        else
            feedkeys("<C-y>", "n")
        end
    end)
    vim.keymap.set("i", "<C-e>", function()
        if cmp.visible() == true then
            cmp.abort()
        else
            feedkeys("<C-e>", "n")
        end
    end)
    vim.keymap.set("i", "<C-l>", function()
        if cmp.visible() == true then
            cmp.complete_common_string()
        elseif ls.expandable() then
            ls.expand()
        else
            cmp.complete({
                config = {
                    sources = {
                        { name = "luasnip" },
                    },
                },
            })
        end
    end)
    vim.keymap.set("i", "<Tab>", function()
        if ls.jumpable(1) then
            ls.jump(1)
        else
            feedkeys("<Tab>", "n")
        end
    end)
    vim.keymap.set("i", "<S-Tab>", function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        else
            feedkeys("<S-Tab>", "n")
        end
    end)
end

M.set_lowercase_marks_keybindings = function()
    -- Use lowercase for global marks and uppercase for local marks.
    local low = function(i) return string.char(97 + i) end
    local upp = function(i) return string.char(65 + i) end

    for i = 0, 25 do
        vim.keymap.set("n", "m" .. low(i), "m" .. upp(i))
    end
    for i = 0, 25 do
        vim.keymap.set("n", "m" .. upp(i), "m" .. low(i))
    end
    for i = 0, 25 do
        vim.keymap.set("n", "'" .. low(i), "'" .. upp(i))
    end
    for i = 0, 25 do
        vim.keymap.set("n", "'" .. upp(i), "'" .. low(i))
    end
end

M.set_misc_keybindings = function()
    local function open(uri)
        local cmd
        if vim.fn.has("win32") == 1 then
            cmd = { "explorer", uri }
        elseif vim.fn.has("macunix") == 1 then
            cmd = { "open", uri }
        else
            if vim.fn.executable("xdg-open") == 1 then
                cmd = { "xdg-open", uri }
            elseif vim.fn.executable("wslview") == 1 then
                cmd = { "wslview", uri }
            else
                cmd = { "open", uri }
            end
        end

        local ret = vim.fn.jobstart(cmd, { detach = true })
        if ret <= 0 then
            local msg = {
                "Failed to open uri",
                ret,
                vim.inspect(cmd),
            }
            vim.notify(table.concat(msg, "\n"), vim.log.levels.ERROR)
        end
    end

    local function open_explorer()
        if require("lazy.core.config").spec.plugins["plain-lf.nvim"] ~= nil then
            require("plain-lf-nvim").open(true)
        else
            vim.cmd("Explore")
        end
    end
    vim.keymap.set({ "n" }, "<leader>e", "", { callback = open_explorer, noremap = true, desc = "Open explorer" })
    vim.keymap.set({ "n" }, "<leader>n", "<cmd>enew<cr>", { desc = "New file" })
    vim.keymap.set({ "n" }, "<leader>q", "<cmd>confirm qall<cr>", { desc = "Quit" })
    vim.keymap.set({ "i", "c" }, "<C-h>", "<C-w>") -- enable ctrl-backspace
    vim.keymap.set({ "i" }, "<C-Del>", "<C-o>dw") -- enable ctrl-delete
    vim.keymap.set({ "n", "x" }, "<A-.>", "zL")
    vim.keymap.set({ "n", "x" }, "<A-,>", "zH")
    vim.keymap.set({ "n", "x" }, "<S-ScrollWheelDown>", "zL")
    vim.keymap.set({ "n", "x" }, "<S-ScrollWheelUp>", "zH")
    vim.keymap.set(
        { "n" },
        "yp",
        '<cmd>:let @" = expand("%:p")<cr><cmd>:let @+ = expand("%:p")<cr><cmd>:let @* = expand("%:p")<cr>',
        { desc = "Yank file path" }
    )
    vim.keymap.set(
        { "n" },
        "yP",
        '<cmd>:let @" = expand("%:t")<cr><cmd>:let @+ = expand("%:t")<cr><cmd>:let @* = expand("%:t")<cr>',
        { desc = "Yank file name" }
    )
    vim.keymap.set(
        { "n" },
        "yd",
        '<cmd>:let @" = expand("%:p:h")<cr><cmd>:let @+ = expand("%:p:h")<cr><cmd>:let @* = expand("%:p:h")<cr>',
        { desc = "Yank file directory path" }
    )
    vim.keymap.set({ "n" }, "<leader>gD", require("cmds").DiffOrg, { desc = "View Unsaved Changes Diff" })
    vim.keymap.set(
        { "n", "x" },
        "<leader>o",
        function() require("aerial").toggle({ direction = "right" }) end,
        { desc = "Open outline" }
    )

    vim.keymap.set(
        { "n" },
        "[u",
        ---@diagnostic disable-next-line: param-type-mismatch
        function() pcall(vim.cmd, "silent " .. vim.v.count1 .. "cprev") end,
        { desc = "Prev quickfix item" }
    )
    vim.keymap.set(
        { "n" },
        "]u",
        ---@diagnostic disable-next-line: param-type-mismatch
        function() pcall(vim.cmd, "silent " .. vim.v.count1 .. "cnext") end,
        { desc = "Next quickfix item" }
    )
    vim.keymap.set({ "n" }, "[U", "<cmd>cfirst<cr>", { desc = "First quickfix item" })
    vim.keymap.set({ "n" }, "]U", "<cmd>clast<cr>", { desc = "Last quickfix item" })

    vim.keymap.set({ "n" }, "[l", "<cmd>lprev<cr>", { desc = "Prev location list item" })
    vim.keymap.set({ "n" }, "]l", "<cmd>lnext<cr>", { desc = "Next location list item" })
    vim.keymap.set({ "n" }, "[L", "<cmd>lfirst<cr>", { desc = "First location list item" })
    vim.keymap.set({ "n" }, "]L", "<cmd>llast<cr>", { desc = "Last location list item" })

    vim.keymap.set({ "n", "x" }, "zM", function()
        vim.wo.foldenable = true
        vim.wo.foldlevel = vim.v.count
    end, { desc = "Set fold level" })
end

M.aerial_keymap = {
    ["?"] = false,
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["["] = "actions.prev_up",
    ["]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
}

M.setup = function()
    vim.keymap.set("", "<leader>", "") -- disable plane space key

    M.set_searching_keybindings()
    M.set_lsp_keybindings()
    M.set_window_and_buffer_keybindings()
    M.set_git_keybindings()
    M.set_toggle_keybindings()
    M.set_autocomplete_keybindings()
    M.set_lowercase_marks_keybindings()
    M.set_misc_keybindings()
end

return M
