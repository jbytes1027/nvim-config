local M = {}

M.diagnostics_hidden = true

M.diagnostics_min_severity = vim.diagnostic.severity.WARN

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

M.setup_default_lsp_config = function()
    vim.lsp.config("*", {
        -- This is cleared elsewhere in an LspAttach autocommand.
        -- There is no autocommand equivalent.
        before_init = function(_, _) vim.b.lsp_statusline_text = "..." end,
    })
end

local root_pattern = function(...)
    local patterns = M.tbl_flatten({ ... })
    return function(startpath)
        startpath = M.strip_archive_subpath(startpath)
        for _, pattern in ipairs(patterns) do
            local match = M.search_ancestors(startpath, function(path)
                for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, "/"), true, true)) do
                    if vim.uv.fs_stat(p) then return path end
                end
            end)

            if match ~= nil then
                local real = vim.uv.fs_realpath(match)
                return real or match -- fallback to original if realpath fails
            end
        end
    end
end

M.enable_intelephense_if_installed = function()
    local cmd = "intelephense"
    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = { cmd, "--stdio" },
        filetypes = { "php" },
        root_markers = {
            "composer.json",
            ".git",
        },
        -- See https://intelephense.com/docs
        settings = {
            intelephense = {
                -- For options, see https://github.com/bmewburn/vscode-intelephense/blob/master/examples/diagnostics/problemCode.ts
                diagnostics = {
                    undefinedTypes = false,
                    undefinedFunctions = false,
                    undefinedConstants = false,
                    undefinedClassConstants = false,
                    undefinedMethods = false,
                    undefinedProperties = false,
                    -- undefinedVariables = false,
                },
                telemetry = { enabled = false },
            },
        },
    })

    vim.lsp.enable("intelephense")
end

M.enable_markdown_oxide_if_installed = function()
    local cmd = "markdown-oxide"

    if vim.fn.executable(cmd) == 0 then return end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config(cmd, {
        cmd = { cmd },
        filetypes = { "markdown" },
        root_markers = { ".git", ".obsidian", ".moxide.toml" },
        single_file_support = true,
        capabilities = capabilities,
    })

    vim.lsp.enable("markdown-oxide")
end

M.enable_lua_language_server_if_installed = function()
    local cmd = "lua-language-server"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = { cmd },
        filetypes = { "lua" },
        root_markers = {
            ".luarc.json",
            ".luarc.jsonc",
            ".luacheckrc",
            ".stylua.toml",
            "stylua.toml",
            "selene.toml",
            "selene.yml",
            ".git",
        },
        single_file_support = true,
        log_level = vim.lsp.protocol.MessageType.Warning,
        settings = {
            Lua = {
                format = {
                    enable = false, -- use style lua
                },
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                        "vim",
                        "require",
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    })

    vim.lsp.enable("lua-language-server")
end

M.enable_omnisharp_if_installed = function()
    local cmd = "omnisharp"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = {
            cmd,
            "-z", -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
            "--hostPID",
            tostring(vim.fn.getpid()),
            "DotNet:enablePackageRestore=false",
            "--encoding",
            "utf-8",
            "--languageserver",
        },
        filetypes = { "cs", "csx", "vb" },
        autostart = false,
        root_dir = root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json"),
        single_file_support = true,
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        settings = { -- For options, see https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options
            FormattingOptions = {
                -- Enables support for reading code style, naming convention and analyzer
                -- settings from .editorconfig.
                EnableEditorConfigSupport = true,
                -- Specifies whether 'using' directives should be grouped and sorted during
                -- document formatting.
                OrganizeImports = true,
            },
            MsBuild = {
                -- If true, MSBuild project system will only load projects for files that
                -- were opened in the editor. This setting is useful for big C# codebases
                -- and allows for faster initialization of code navigation features only
                -- for projects that are relevant to code that is being edited. With this
                -- setting enabled OmniSharp may load fewer projects and may thus display
                -- incomplete reference lists for symbols.
                LoadProjectsOnDemand = nil,
            },
            RoslynExtensionsOptions = {
                DocumentAnalysisTimeoutMs = 30000,
                EnableDecompilationSupport = true,
                -- Enables support for showing unimported types and unimported extension
                -- methods in completion lists. When committed, the appropriate using
                -- directive will be added at the top of the current file. This option can
                -- have a negative impact on initial completion responsiveness,
                -- particularly for the first few completion sessions after opening a
                -- solution.
                EnableImportCompletion = true,
                EnableAsyncCompletion = true,
                -- Enables support for roslyn analyzers, code fixes and rulesets.
                EnableAnalyzersSupport = nil,
                -- Only run analyzers against open files
                AnalyzeOpenDocumentsOnly = true,
                InlayHintsOptions = {
                    EnableForParameters = true,
                    ForLiteralParameters = true,
                    ForIndexerParameters = true,
                    ForObjectCreationParameters = true,
                    ForOtherParameters = true,
                    SuppressForParametersThatDifferOnlyBySuffix = false,
                    SuppressForParametersThatMatchMethodIntent = false,
                    SuppressForParametersThatMatchArgumentName = false,
                    EnableForTypes = true,
                    ForImplicitVariableTypes = true,
                    ForLambdaParameterTypes = true,
                    ForImplicitObjectCreation = true,
                },
            },
            Script = {
                Enabled = true,
                DefaultTargetFramework = "net461",
                EnableScriptNuGetReferences = false,
            },
            Sdk = {
                -- Specifies whether to include preview versions of the .NET SDK when
                -- determining which version to use for project loading.
                IncludePrereleases = true,
            },
        },
    })

    vim.lsp.enable(cmd)
end

M.enable_lemminx_if_installed = function()
    local cmd = "lemminx"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = { cmd },
        filetypes = { "xml", "xsd", "xslt", "svg" },
        root_markers = { ".git" },
    })

    vim.lsp.enable("lemminx")
end

M.enable_vscode_json_languageserver_if_installed = function()
    local cmd = "vscode-json-languageserver"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = function(dispatchers, config)
            if (config or {}).root_dir then
                local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
                if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
            end
            return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
        end,
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        init_options = {
            provideFormatter = false,
        },
    })

    vim.lsp.enable(cmd)
end

M.enable_vscode_html_language_server_if_installed = function()
    local cmd = "vscode-html-language-server"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = function(dispatchers, config)
            local cmd = "vscode-html-language-server"
            if (config or {}).root_dir then
                local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
                if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
            end
            return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
        end,
        filetypes = { "html" },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_markers = { "package.json", ".git" },
        settings = {},
        init_options = {
            provideFormatter = true,
            embeddedLanguages = { css = true, javascript = true },
            configurationSection = { "html", "css", "javascript" },
        },
    })

    vim.lsp.enable(cmd)
end

M.enable_vscode_css_language_server_if_installed = function()
    local cmd = "vscode-css-language-server"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = function(dispatchers, config)
            local cmd = "vscode-css-language-server"
            if (config or {}).root_dir then
                local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
                if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
            end
            return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
        end,
        filetypes = { "css", "scss", "less" },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_markers = { "package.json", ".git" },
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
        },
    })

    vim.lsp.enable(cmd)
end

M.enable_ty_if_installed = function()
    local cmd = "ty"

    if vim.fn.executable(cmd) == 0 then return end

    vim.lsp.config(cmd, {
        cmd = { cmd, "server" },
        filetypes = { "python" },
        root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    })

    vim.lsp.enable(cmd)
end

M.enable_typescript_language_server_if_installed = function()
    local cmd = "typescript-language-server"

    if vim.fn.executable(cmd) == 0 then return end

    -- Sourced from https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua
    vim.lsp.config(cmd, {
        init_options = { hostInfo = "neovim" },
        cmd = function(dispatchers, config)
            local cmd = "typescript-language-server"
            if (config or {}).root_dir then
                local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
                if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
            end
            return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
        end,
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_dir = function(bufnr, on_dir)
            -- The project root is where the LSP can be started from
            -- As stated in the documentation above, this LSP supports monorepos and simple projects.
            -- We select then from the project root, which is identified by the presence of a package
            -- manager lock file.
            local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
            -- Give the root markers equal priority by wrapping them in a table
            root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
                or vim.list_extend(root_markers, { ".git" })
            -- exclude deno
            local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
            local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
            local project_root = vim.fs.root(bufnr, root_markers)
            if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
                -- deno lock is closer than package manager lock, abort
                return
            end
            if deno_root and (not project_root or #deno_root >= #project_root) then
                -- deno config is closer than or equal to package manager lock, abort
                return
            end
            -- project is standard TS, not deno
            -- We fallback to the current working directory if no project root is found
            on_dir(project_root or vim.fn.getcwd())
        end,
        handlers = {
            -- handle rename request for certain code actions like extracting functions / types
            ["_typescript.rename"] = function(_, result, ctx)
                local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
                vim.lsp.util.show_document({
                    uri = result.textDocument.uri,
                    range = {
                        start = result.position,
                        ["end"] = result.position,
                    },
                }, client.offset_encoding)
                vim.lsp.buf.rename()
                return vim.NIL
            end,
        },
        commands = {
            ["editor.action.showReferences"] = function(command, ctx)
                local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
                local file_uri, position, references = unpack(command.arguments)

                local quickfix_items = vim.lsp.util.locations_to_items(references --[[@as any]], client.offset_encoding)
                vim.fn.setqflist({}, " ", {
                    title = command.title,
                    items = quickfix_items,
                    context = {
                        command = command,
                        bufnr = ctx.bufnr,
                    },
                })

                vim.lsp.util.show_document({
                    uri = file_uri --[[@as string]],
                    range = {
                        start = position --[[@as lsp.Position]],
                        ["end"] = position --[[@as lsp.Position]],
                    },
                }, client.offset_encoding)
                ---@diagnostic enable: assign-type-mismatch

                vim.cmd("botright copen")
            end,
        },
        on_attach = function(client, bufnr)
            -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
            -- `vim.lsp.buf.code_action()` if specified in `context.only`.
            vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
                local source_actions = vim.tbl_filter(
                    function(action) return vim.startswith(action, "source.") end,
                    client.server_capabilities.codeActionProvider.codeActionKinds
                )

                vim.lsp.buf.code_action({
                    context = {
                        only = source_actions,
                        diagnostics = {},
                    },
                })
            end, {})

            -- Go to source definition command
            vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptGoToSourceDefinition", function()
                local win = vim.api.nvim_get_current_win()
                local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
                client:exec_cmd({
                    command = "_typescript.goToSourceDefinition",
                    title = "Go to source definition",
                    arguments = { params.textDocument.uri, params.position },
                }, { bufnr = bufnr }, function(err, result)
                    if err then
                        vim.notify("Go to source definition failed: " .. err.message, vim.log.levels.ERROR)
                        return
                    end
                    if not result or vim.tbl_isempty(result) then
                        vim.notify("No source definition found", vim.log.levels.INFO)
                        return
                    end
                    vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
                end)
            end, { desc = "Go to source definition" })
        end,
    })

    vim.lsp.enable(cmd)
end

-- For good config defaults, see https://github.com/neovim/nvim-lspconfig/tree/master/lsp

M.enable_installed = function()
    M.setup_default_lsp_config()
    M.enable_omnisharp_if_installed()
    M.enable_intelephense_if_installed()
    M.enable_markdown_oxide_if_installed()
    M.enable_intelephense_if_installed()
    M.enable_lua_language_server_if_installed()
    M.enable_lemminx_if_installed()
    M.enable_vscode_json_languageserver_if_installed()
    M.enable_vscode_html_language_server_if_installed()
    M.enable_vscode_css_language_server_if_installed()
    M.enable_ty_if_installed()
    M.enable_typescript_language_server_if_installed()
end

return M
