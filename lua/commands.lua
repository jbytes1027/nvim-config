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

-- Types of paths to support:
-- C:\temp logs\file.txt:line 80
-- C:\temp logs\file.txt:80
-- C:\temp logs\file.txt:
-- C:\temp logs\file.txt
-- /temp logs/file.txt:line 80
-- /temp logs/file.txt:80
-- /temp logs/file.txt:
-- /temp logs/file.txt
function M.JumpToFileLine(input)
    if not input or input == "" then
        print("No input provided")
        return
    end

    input = vim.trim(input)

    local path, line

    -- Match ":line 80" at end
    path, line = input:match("^(.*):line%s+(%d+)$")

    -- Match ":80" at end
    if not path then
        path, line = input:match("^(.*):(%d+)$")
    end

    -- Match trailing ":"
    if not path then
        path = input:match("^(.*):$")
    end

    -- Fallback: whole string is path
    if not path then
        path = input
    end

    -- Expand and normalize
    path = vim.fn.expand(path)

    -- print("Opening:", path, "Line:", line)

    -- Open file safely
    vim.cmd("edit " .. vim.fn.fnameescape(path))

    -- Move cursor
    if line then
        vim.api.nvim_win_set_cursor(0, { tonumber(line), 0 })
    else
        vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end
end

vim.api.nvim_create_user_command('Goto', function(params)
    M.JumpToFileLine(params.args)
end, { nargs = 1 })

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
