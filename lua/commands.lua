M = {}

vim.api.nvim_create_user_command("CF", function(args)
    if args.args == "" and args.bang then
        vim.fn.setqflist({})
    elseif args.args ~= "" then
        vim.cmd("packadd cfilter")
        if args.bang then
            vim.cmd("Cfilter! " .. args.args)
        else
            vim.cmd("Cfilter " .. args.args)
        end
    end
end, { bang = true, nargs = "?" })

vim.api.nvim_create_user_command("LF", function(args)
    if args.args == "" and args.bang then
        vim.fn.setloclist(0, {})
    elseif args.args ~= "" then
        vim.cmd("packadd cfilter")
        if args.bang then
            vim.cmd("Lfilter! " .. args.args)
        else
            vim.cmd("Lfilter " .. args.args)
        end
    end
end, { bang = true, nargs = "?" })
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
