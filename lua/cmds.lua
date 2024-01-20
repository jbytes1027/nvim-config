M = {}

function M.DiffOrg()
    local og_filetype = vim.o.filetype
    vim.cmd(
        "vert new | set buftype=nofile | set filetype="
            .. og_filetype
            .. "| read ++edit # | 0d_| diffthis | wincmd p | diffthis"
    )
end

vim.api.nvim_create_user_command("DiffOrg", M.DiffOrg, {})

return M
