local cterm_colors = {
    dark_bg = 0,
    dark_red = 1,
    dark_green = 2,
    dark_yellow = 3,
    dark_blue = 4,
    dark_magenta = 5,
    dark_cyan = 6,
    dark_fg = 7,
    light_bg = 8,
    light_red = 9,
    light_green = 10,
    light_yellow = 11,
    light_blue = 12,
    light_magenta = 13,
    light_cyan = 14,
    light_fg = 15,
}

local config = {
    invert_signs = false,
    bold = true,
}

local groups = {
    Normal = { ctermfg = cterm_colors.light_fg },
    NormalNC = {},
    TabLineFill = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_fg },
    TabLineSel = { ctermfg = cterm_colors.white, bold = true },
    TabLine = { link = "TabLineFill" },
    MatchParen = { ctermbg = cterm_colors.light_bg },
    ColorColumn = { ctermbg = cterm_colors.light_bg },
    Conceal = { ctermfg = cterm_colors.light_blue },
    NonText = { link = "Comment" },
    Whitespace = { link = "Comment" },
    SpecialKey = { ctermfg = cterm_colors.light_bg },
    Visual = { ctermbg = cterm_colors.light_blue, ctermfg = cterm_colors.dark_bg },
    VisualNOS = { link = "Visual" },
    Search = { ctermbg = cterm_colors.light_yellow, ctermfg = cterm_colors.dark_bg },
    IncSearch = { ctermbg = cterm_colors.light_magenta, ctermfg = cterm_colors.dark_bg },
    CurSearch = { link = "IncSearch" },
    QuickFixLine = { ctermfg = cterm_colors.light_magenta },
    LineNr = { ctermfg = cterm_colors.dark_fg },
    Underlined = { underline = true },
    Directory = { ctermfg = cterm_colors.light_blue, bold = config.bold },
    StatusLine = { ctermfg = cterm_colors.dark_fg, underline = true, bold = true },
    StatusLineNC = { ctermfg = cterm_colors.dark_fg, underline = true },
    WinSeparator = { ctermfg = cterm_colors.dark_fg },
    WildMenu = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.light_bg, bold = config.bold },
    ErrorMsg = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.light_red, bold = config.bold },
    MoreMsg = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    ModeMsg = { ctermfg = cterm_colors.light_fg, bold = config.bold },
    Question = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    WarningMsg = { ctermfg = cterm_colors.light_red, bold = config.bold },
    SignColumn = {},
    Folded = { ctermfg = cterm_colors.dark_fg, ctermbg = cterm_colors.light_bg, italic = true },
    FoldColumn = { ctermfg = cterm_colors.dark_fg },
    Error = { ctermfg = cterm_colors.light_red, bold = config.bold, reverse = true },
    vCursor = { link = "Cursor" },
    iCursor = { link = "Cursor" },
    lCursor = { link = "Cursor" },
    CursorLine = { ctermbg = cterm_colors.light_bg },
    CursorColumn = { link = "CursorLine" },
    CursorLineNr = { ctermbg = cterm_colors.light_bg },
    Cursor = { ctermbg = cterm_colors.light_fg },
    Pmenu = { ctermfg = cterm_colors.light_fg, ctermbg = cterm_colors.light_bg },
    PmenuSel = { ctermfg = cterm_colors.light_bg, ctermbg = cterm_colors.light_blue },
    PmenuSbar = { ctermbg = cterm_colors.light_bg },
    PmenuThumb = { ctermbg = cterm_colors.dark_fg },
    FloatBorder = { link = "WinSeparator" },
    NormalFloat = { link = "Pmenu" },
    DiagnosticError = { ctermfg = cterm_colors.light_red },
    DiagnosticSignError = {
        ctermfg = cterm_colors.light_red,
        reverse = config.invert_signs,
    },
    DiagnosticWarn = { ctermfg = cterm_colors.light_yellow },
    DiagnosticSignWarn = {
        ctermfg = cterm_colors.light_green,
        reverse = config.invert_signs,
    },
    DiagnosticInfo = { ctermfg = cterm_colors.light_blue },
    DiagnosticSignInfo = {
        ctermfg = cterm_colors.light_blue,
        reverse = config.invert_signs,
    },
    DiagnosticHint = { ctermfg = cterm_colors.light_cyan },
    DiagnosticSignHint = {
        ctermfg = cterm_colors.light_cyan,
        reverse = config.invert_signs,
    },

    -- Extensions
    DiffDelete = { ctermbg = cterm_colors.dark_red, ctermfg = cterm_colors.dark_red },
    DiffAdd = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    DiffChange = {},
    DiffText = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    ["@attribute.diff"] = { ctermfg = cterm_colors.light_magenta },
    ["@diff.plus"] = { ctermfg = cterm_colors.dark_green },
    ["@diff.minus"] = { ctermfg = cterm_colors.dark_red },
    -- ["@diff.plus"] = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    -- ["@diff.minus"] = { ctermbg = cterm_colors.dark_red, ctermfg = cterm_colors.dark_bg },
    DiagnosticVirtualTextError = { ctermbg = cterm_colors.light_red, ctermfg = cterm_colors.dark_bg, bold = true },
    DiagnosticVirtualTextWarn = { ctermbg = cterm_colors.light_yellow, ctermfg = cterm_colors.dark_bg, bold = true },
    DiagnosticVirtualTextInfo = { ctermbg = cterm_colors.light_blue, ctermfg = cterm_colors.dark_bg, bold = true },
    DiagnosticVirtualTextHint = { ctermbg = cterm_colors.light_cyan, ctermfg = cterm_colors.dark_bg, bold = true },
    DiagnosticOk = { ctermfg = cterm_colors.light_green, reverse = config.invert_signs },
    LspReferenceRead = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    LspReferenceText = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    LspReferenceWrite = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    LspCodeLens = { ctermfg = cterm_colors.light_bg },
    LspSignatureActiveParameter = { link = "Search" },
    LspInlayHint = { link = "comment" },
    gitcommitSelectedFile = { ctermfg = cterm_colors.light_green },
    gitcommitDiscardedFile = { ctermfg = cterm_colors.light_red },
    GitSignsAdd = { ctermfg = cterm_colors.light_green },
    GitSignsChange = { ctermfg = cterm_colors.light_blue },
    GitSignsDelete = { ctermfg = cterm_colors.light_red },
    GitSignsAddNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_green },
    GitSignsChangeNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_green },
    GitSignsDeleteNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_red },
    debugPC = { ctermbg = cterm_colors.light_blue },
    netrwDir = { ctermfg = cterm_colors.light_cyan },
    netrwClassify = { ctermfg = cterm_colors.light_cyan },
    netrwLink = { ctermfg = cterm_colors.light_bg },
    netrwSymLink = { ctermfg = cterm_colors.light_fg },
    netrwExe = { ctermfg = cterm_colors.light_yellow },
    netrwComment = { ctermfg = cterm_colors.light_bg },
    netrwList = { ctermfg = cterm_colors.light_blue },
    netrwHelpCmd = { ctermfg = cterm_colors.light_cyan },
    netrwVersion = { ctermfg = cterm_colors.light_green },
    TelescopeSelection = { ctermfg = cterm_colors.light_blue, bold = config.bold },
    TelescopePromptPrefix = { link = "TelescopeNormal" },
    CmpItemAbbrDeprecated = { ctermfg = cterm_colors.light_fg },
    CmpItemAbbrMatch = { ctermfg = cterm_colors.light_blue },
    CmpItemMenu = { ctermfg = cterm_colors.light_bg },
    CmpItemKind = { ctermfg = cterm_colors.dark_fg },
    AerialConstructorIcon = {},

    -- Code Highlighting Base
    Title = { ctermfg = cterm_colors.light_green, bold = config.bold },
    Constant = { ctermfg = cterm_colors.light_blue },
    Character = { link = "Constant" },
    String = { link = "Constant" },
    Boolean = { link = "Constant" },
    Number = { link = "Constant" },
    Float = { link = "Constant" },
    Type = { ctermfg = cterm_colors.light_green },
    Attribute = { ctermfg = cterm_colors.light_green },
    Identifier = { ctermfg = cterm_colors.light_green }, -- any variable name, includes html tags
    PreCondit = { ctermfg = cterm_colors.light_cyan },
    Structure = { ctermfg = cterm_colors.light_cyan },
    PreProc = { ctermfg = cterm_colors.light_magenta },
    Tag = { link = "Identifier" },
    Comment = { ctermfg = cterm_colors.dark_fg },
    Include = { ctermfg = cterm_colors.light_red },
    Repeat = { ctermfg = cterm_colors.light_red },
    Statement = { ctermfg = cterm_colors.light_red },
    Conditional = { link = "Statement" }, -- if, then, else, endif, switch, etc.
    Exception = { link = "Statement" },
    Label = { link = "Statement" }, -- case, default, etc.
    Keyword = { link = "Statement" },
    Operator = {}, -- "sizeof", "+", "*", etc.
    Function = { link = "Normal" }, -- function name (also: methods for classes) (both definitions and calls)
    Special = { ctermfg = cterm_colors.light_magenta },
    Todo = {},
    Done = {},

    -- Code Highlighting Extensions
    ["@property.yaml"] = { link = "Identifier" },
    jsonKeyword = { link = "Identifier" },
    markdownCode = { link = "Constant" },
    markdownEscape = { link = "None" },
    mkdLineBreak = { link = "None" },
    helpExample = { link = "Normal" },
    ["@field"] = { link = "@property" },
    ["@constructor"] = { link = "Function" },
    ["@none"] = { link = "Normal" }, -- used for C# format strings
    ["@string"] = { link = "String" },
    ["@string.regex"] = { link = "String" },
    ["@string.escape"] = { link = "String" },
    ["@string.special"] = { link = "String" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@float"] = { link = "Float" },
    ["@module"] = {},
    ["@module.builtin"] = { link = "@module" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@function.macro"] = { link = "Function" },
    ["@method"] = { link = "Function" },
    ["@parameter"] = {},
    ["@keyword"] = {},
    ["@keyword.directive"] = { link = "Keyword" },
    ["@keyword.directive.markdown"] = {},
    ["@keyword.import"] = { link = "Keyword" },
    ["@keyword.return"] = { link = "Keyword" },
    ["@keyword.function"] = { link = "Type" },
    ["@keyword.modifier"] = { link = "Type" },
    ["@keyword.type"] = { link = "Type" },
    ["@keyword.operator"] = { link = "Operator" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@conditional"] = { link = "Conditional" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@repeat"] = { link = "Repeat" },
    ["@debug"] = { link = "Debug" },
    ["@label"] = { link = "Label" },
    ["@include"] = { link = "Include" },
    ["@exception"] = { link = "Exception" },
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { link = "@type" },
    ["@attribute"] = { link = "Attribute" },
    ["@attribute.builtin"] = { link = "@attribute" },
    ["@variable"] = {},
    ["@variable.builtin"] = { link = "@variable" },
    ["@variable.parameter.builtin"] = { link = "@variable" },
    ["@constant.builtin"] = { link = "Constant" },
    ["@text.literal"] = { link = "String" },
    ["@tag"] = { link = "Tag" },
    ["@tag.builtin"] = { link = "@tag" },
    ["@property"] = {}, -- class properties and lhs of json properties
    ["@property.json"] = { link = "Tag" }, -- class properties and lhs of json properties
    ["@property.jsonc"] = { link = "Tag" }, -- class properties and lhs of jsonc properties
    ["editorconfigUnknownProperty"] = { link = "Identifier" },
    ["@text.title.1.html"] = {},
    ["@text.title.2.html"] = {},
    ["@text.title.3.html"] = {},
    ["@text.title.4.html"] = {},
    ["@text.title.5.html"] = {},
    ["@text.title.6.html"] = {},
    ["@text.title.html"] = {},
    ["@text.literal.html"] = {},
    ["@tag.attribute"] = { link = "Delimiter" },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@macro" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@constructor" },
    ["@lsp.type.macro"] = { link = "@macro" },
    ["@lsp.type.method"] = { link = "@method" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type.definition" },
    ["@lsp.type.variable"] = { link = "@variable" },
    ["@markup.heading"] = { link = "Title" },
    ["@markup.link"] = { link = "Underlined" },
    ["@markup.link.markdown_inline"] = {},
    ["@markup.link.label.markdown_inline"] = {},
    ["@markup.quote"] = { link = "String" },
    ["@markup.math"] = { link = "String" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.raw.block"] = { link = "@markup.raw" },
    ["@markup.list"] = { link = "Type" },
    ["@markup.list.checked"] = { link = "@markup.list" },
    ["@markup.list.unchecked"] = { link = "@markup.list" },
    ["@punctuation.special.markdown"] = { link = "@punctuation" },
    ["Delimiter"] = {},
}

vim.o.termguicolors = false
vim.o.background = "dark" -- prevents colors from being reset
for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
end
