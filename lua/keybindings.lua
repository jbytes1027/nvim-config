-- NOTES
-- Emulate a key for passthrough with the following
-- local key = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
-- vim.api.nvim_feedkeys(key, "n", true)

-- Searching
vim.keymap.set({ "n" }, "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
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
    function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
    { desc = "Find buffer diagnostics" }
)
vim.keymap.set(
    { "n" },
    "<leader>fD",
    function() require("telescope.builtin").diagnostics() end,
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
vim.keymap.set({ "n" }, "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Find keymaps" })
vim.keymap.set(
    { "n" },
    "<leader>fm",
    function() require("telescope.builtin").marks() end,
    { desc = "Find man pages" }
)
vim.keymap.set({ "n" }, "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Find buffers" })
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
vim.keymap.set({ "n" }, "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Find help" })
vim.keymap.set({ "n" }, "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Find history" })
vim.keymap.set(
    { "n" },
    "<leader>fr",
    function() require("telescope.builtin").registers() end,
    { desc = "Find registers" }
)
vim.keymap.set({ "n" }, "<leader>fw", function() require("telescope.builtin").live_grep() end, { desc = "Find words" })
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

-- Lsp
vim.keymap.set({ "n" }, "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
vim.keymap.set({ "n" }, "<leader>lI", "<cmd>NullLsInfo<cr>", { desc = "Null-ls information" })
vim.keymap.set({ "n" }, "K", function() vim.lsp.buf.hover() end, { desc = "Hover symbol details" })
vim.keymap.set({ "n" }, "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "LSP code action" })
vim.keymap.set({ "v" }, "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "LSP code action" })
vim.keymap.set(
    { "n" },
    "gd",
    function() vim.lsp.buf.definition() end,
    { desc = "Show the definition of current symbol" }
)
vim.keymap.set({ "n" }, "gD", function() vim.lsp.buf.declaration() end, { desc = "Declaration of current symbol" })
vim.keymap.set(
    { "n" },
    "gI",
    function() vim.lsp.buf.implementation() end,
    { desc = "Implementation of current symbol" }
)
vim.keymap.set({ "n" }, "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format buffer" })
vim.keymap.set({ "v" }, "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format selection" })
vim.keymap.set({ "n" }, "<leader>lc", function() vim.lsp.buf.incoming_calls() end, { desc = "View incoming calls" })
vim.keymap.set({ "n" }, "<leader>lC", function() vim.lsp.buf.outgoing_calls() end, { desc = "View outgoing calls" })
vim.keymap.set({ "n" }, "gr", function() vim.lsp.buf.references() end, { desc = "References of current symbol" })
vim.keymap.set({ "n" }, "<leader>lR", function() vim.lsp.buf.references() end, { desc = "Search references" })
vim.keymap.set({ "n" }, "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename current symbol" })
vim.keymap.set({ "n" }, "<leader>lh", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
vim.keymap.set({ "n" }, "<leader>ll", vim.lsp.codelens.refresh, { desc = "LSP CodeLens refresh" })
vim.keymap.set({ "n" }, "<leader>lL", vim.lsp.codelens.run, { desc = "LSP CodeLens run" })
vim.keymap.set({ "n" }, "gy", function() vim.lsp.buf.type_definition() end, { desc = "Definition of current type" })
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

-- Lsp
vim.keymap.set({ "n" }, "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "Hover diagnostics" })
vim.keymap.set(
    { "n" },
    "[d",
    function() vim.diagnostic.goto_prev({ float = true }) end,
    { desc = "Previous diagnostic" }
)
vim.keymap.set({ "n" }, "]d", function() vim.diagnostic.goto_next({ float = true }) end, { desc = "Next diagnostic" })

-- Git
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

vim.keymap.set({ "n" }, "<leader>gl", function() require("gitsigns").blame_line() end, { desc = "View git blame" })
vim.keymap.set(
    { "n" },
    "<leader>gL",
    function() require("gitsigns").blame_line({ full = true }) end,
    { desc = "View full git blame" }
)
vim.keymap.set({ "n" }, "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview git hunk" })
vim.keymap.set({ "n" }, "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Git hunk" })
vim.keymap.set(
    { "v" },
    "<leader>gr",
    function()
        require("gitsigns").reset_hunk({ vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1] })
    end,
    { desc = "Reset Git hunk" }
)
vim.keymap.set({ "n" }, "<leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Git buffer" })
vim.keymap.set({ "n" }, "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Git hunk" })
vim.keymap.set(
    { "v" },
    "<leader>gs",
    function()
        require("gitsigns").stage_hunk({ vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1] })
    end,
    { desc = "Stage Git hunk" }
)
vim.keymap.set({ "n" }, "<leader>gS", function() require("gitsigns").stage_buffer() end, { desc = "Stage Git buffer" })
vim.keymap.set({ "n" }, "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo Git stage" })
vim.keymap.set(
    { "n" },
    "<leader>gU",
    function() require("gitsigns").reset_buffer_index() end,
    { desc = "Unstage Git file" }
)
vim.keymap.set({ "n" }, "<leader>gd", function() require("gitsigns").diffthis() end, { desc = "View Git diff" })
-- Ui mods
vim.keymap.set({ "n" }, "<leader>uc", "<cmd>ColorizerToggle<cr>", { desc = "Toggle color highlight" })
vim.keymap.set({ "n" }, "<leader>ud", require("ui").toggle_diagnostics, { desc = "Toggle diagnostics" })
vim.keymap.set({ "n" }, "<leader>ug", require("ui").toggle_signcolumn, { desc = "Toggle signcolumn" })
vim.keymap.set({ "n" }, "<leader>ui", require("ui").set_indent, { desc = "Change indent setting" })
vim.keymap.set({ "n" }, "<leader>ul", require("ui").toggle_statusline, { desc = "Toggle statusline" })
vim.keymap.set({ "n" }, "<leader>un", require("ui").change_number, { desc = "Change line numbering" })
vim.keymap.set({ "n" }, "<leader>up", require("ui").toggle_paste, { desc = "Toggle paste mode" })
vim.keymap.set({ "n" }, "<leader>us", require("ui").toggle_spell, { desc = "Toggle spellcheck" })
vim.keymap.set({ "n" }, "<leader>uS", require("ui").toggle_conceal, { desc = "Toggle conceal" })
vim.keymap.set({ "n" }, "<leader>ut", require("ui").toggle_tabline, { desc = "Toggle tabline" })
vim.keymap.set({ "n" }, "<leader>uw", require("ui").toggle_wrap, { desc = "Toggle wrap" })
vim.keymap.set(
    { "n" },
    "<leader>uy",
    require("ui").toggle_buffer_syntax,
    { desc = "Toggle syntax highlighting (buffer)" }
)
vim.keymap.set({ "n" }, "<leader>uh", require("ui").toggle_foldcolumn, { desc = "Toggle foldcolumn" })

-- Autocomplete
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
vim.keymap.set("i", "<C-u>", function() cmp.scroll_docs(-4) end)
vim.keymap.set("i", "<C-d>", function() cmp.scroll_docs(4) end)
vim.keymap.set("i", "<C-y>", function() cmp.confirm() end)
vim.keymap.set("i", "<C-e>", function() cmp.abort() end)
vim.keymap.set("i", "<Tab>", function()
    if cmp.visible() == false then cmp.complete() end
    cmp.select_next_item()
end)
vim.keymap.set("i", "<S-Tab>", function()
    if cmp.visible() == false then cmp.complete() end
    cmp.select_next_item()
end)
vim.keymap.set("i", "<C-l>", function() cmp.complete_common_string() end)

-- Use lowercase for global marks and uppercase for local marks.
local low = function(i) return string.char(97+i) end
local upp = function(i) return string.char(65+i) end

for i=0,25 do vim.keymap.set("n", "m"..low(i), "m"..upp(i)) end
for i=0,25 do vim.keymap.set("n", "m"..upp(i), "m"..low(i)) end
for i=0,25 do vim.keymap.set("n", "'"..low(i), "'"..upp(i)) end
for i=0,25 do vim.keymap.set("n", "'"..upp(i), "'"..low(i)) end

-- Misc
vim.keymap.set("", "<leader>", "") -- disable plane space key
local function open_explorer()
    if require("lazy.core.config").spec.plugins["ranger.nvim"] ~= nil then
        require("ranger-nvim").open(true)
    else
        vim.cmd("Explore")
    end
end
vim.keymap.set({ "n" }, "<leader>e", "", { callback = open_explorer, noremap = true, desc = "Open explorer" })
vim.keymap.set(
    "n",
    "<leader>/",
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    { desc = "Toggle comment line" }
)
vim.keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", {
    desc = "Toggle comment for selection",
})
vim.keymap.set({ "n" }, "<leader>n", "<cmd>enew<cr>", { desc = "New file" })
vim.keymap.set({ "n" }, "<leader>q", "<cmd>confirm qall<cr>", { desc = "Quit" })
vim.keymap.set({ "n" }, "<A-q>", "<cmd>confirm qall<cr>", { desc = "Quit" })
vim.keymap.set({ "i", "c" }, "<C-h>", "<C-w>") -- enable ctrl-backspace
vim.keymap.set({ "i" }, "<C-Del>", "<C-o>dw")  -- enable ctrl-delete
