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
    italic = false,
}

local groups = {
    Normal = { ctermfg = cterm_colors.light_fg },
    NormalNC = {},
    TabLineFill = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_fg },
    TabLineSel = { ctermfg = cterm_colors.white, bold = config.bold },
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
    LineNr = { ctermfg = cterm_colors.dark_fg },
    Underlined = { underline = true },
    Directory = { ctermfg = cterm_colors.light_blue, bold = config.bold },
    StatusLine = { ctermfg = cterm_colors.dark_fg, underline = true, bold = config.bold },
    StatusLineNC = { ctermfg = cterm_colors.dark_fg, underline = true },
    WinSeparator = { ctermfg = cterm_colors.dark_fg },
    WildMenu = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.light_bg, bold = config.bold },
    ErrorMsg = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.light_red, bold = config.bold },
    MoreMsg = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    ModeMsg = { ctermfg = cterm_colors.light_fg, bold = config.bold },
    Question = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    WarningMsg = { ctermfg = cterm_colors.light_red, bold = config.bold },
    SignColumn = {},
    Folded = { ctermfg = cterm_colors.dark_fg, ctermbg = cterm_colors.light_bg, italic = config.italic },
    FoldColumn = { ctermfg = cterm_colors.dark_fg },
    Error = { ctermfg = cterm_colors.light_red, bold = config.bold, reverse = true },
    Cursor = { ctermbg = cterm_colors.light_fg, ctermfg = cterm_colors.dark_bg },
    vCursor = { link = "Cursor" },
    iCursor = { link = "Cursor" },
    lCursor = { link = "Cursor" },
    CursorLine = { ctermbg = cterm_colors.light_bg },
    CursorColumn = { link = "CursorLine" },
    CursorLineNr = { ctermbg = cterm_colors.light_bg },
    Pmenu = { ctermfg = cterm_colors.light_fg, ctermbg = cterm_colors.light_bg },
    PmenuSel = { ctermfg = cterm_colors.light_bg, ctermbg = cterm_colors.light_blue },
    PmenuSbar = { ctermbg = cterm_colors.light_bg },
    PmenuThumb = { ctermbg = cterm_colors.dark_fg },
    FloatBorder = { link = "WinSeparator" },
    NormalFloat = { link = "Pmenu" },

    -- Diagnostics
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
    DiagnosticVirtualTextError = {
        ctermbg = cterm_colors.light_red,
        ctermfg = cterm_colors.dark_bg,
        bold = config.bold,
    },
    DiagnosticVirtualTextWarn = {
        ctermbg = cterm_colors.light_yellow,
        ctermfg = cterm_colors.dark_bg,
        bold = config.bold,
    },
    DiagnosticVirtualTextInfo = {
        ctermbg = cterm_colors.light_blue,
        ctermfg = cterm_colors.dark_bg,
        bold = config.bold,
    },
    DiagnosticVirtualTextHint = {
        ctermbg = cterm_colors.light_cyan,
        ctermfg = cterm_colors.dark_bg,
        bold = config.bold,
    },
    DiagnosticOk = { ctermfg = cterm_colors.light_green, reverse = config.invert_signs },

    DiffDelete = { ctermbg = cterm_colors.dark_red, ctermfg = cterm_colors.dark_red },
    DiffAdd = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    DiffChange = {},
    DiffText = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    ["@attribute.diff"] = { ctermfg = cterm_colors.light_magenta },
    ["@diff.plus"] = { ctermfg = cterm_colors.dark_green },
    ["@diff.minus"] = { ctermfg = cterm_colors.dark_red },
    -- ["@diff.plus"] = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    -- ["@diff.minus"] = { ctermbg = cterm_colors.dark_red, ctermfg = cterm_colors.dark_bg },

    LspReferenceRead = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    LspReferenceText = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    LspReferenceWrite = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    LspCodeLens = { ctermfg = cterm_colors.light_bg },
    LspSignatureActiveParameter = { link = "Visual" },
    LspInlayHint = { link = "comment" },
    gitcommitSelectedFile = { ctermfg = cterm_colors.light_green },
    gitcommitDiscardedFile = { ctermfg = cterm_colors.light_red },
    GitSignsAdd = { ctermfg = cterm_colors.light_green },
    GitSignsChange = { ctermfg = cterm_colors.light_blue },
    GitSignsDelete = { ctermfg = cterm_colors.light_red },
    GitSignsAddNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_green },
    GitSignsChangeNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_green },
    GitSignsDeleteNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_red },
    TelescopeSelection = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.dark_bg, reverse = true },
    TelescopeMatching = { ctermfg = cterm_colors.light_blue, bold = config.bold, underline = true },
    TelescopePromptPrefix = { link = "TelescopeNormal" },
    CmpItemAbbrDeprecated = { ctermfg = cterm_colors.light_fg },
    CmpItemAbbrMatch = { ctermfg = cterm_colors.light_blue },
    CmpItemMenu = { ctermfg = cterm_colors.light_bg },
    CmpItemKind = { ctermfg = cterm_colors.dark_fg },

    -- Netrw plugin
    netrwDir = { ctermfg = cterm_colors.light_cyan },
    netrwClassify = { ctermfg = cterm_colors.light_cyan },
    netrwLink = { ctermfg = cterm_colors.light_bg },
    netrwSymLink = { ctermfg = cterm_colors.light_fg },
    netrwExe = { ctermfg = cterm_colors.light_yellow },
    netrwComment = { ctermfg = cterm_colors.light_bg },
    netrwList = { ctermfg = cterm_colors.light_blue },
    netrwHelpCmd = { ctermfg = cterm_colors.light_cyan },
    netrwVersion = { ctermfg = cterm_colors.light_green },

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
    PreCondit = { ctermfg = cterm_colors.light_fg },
    Structure = { ctermfg = cterm_colors.light_fg },
    PreProc = { ctermfg = cterm_colors.light_fg },
    Tag = { link = "Identifier" },
    Comment = { ctermfg = cterm_colors.dark_fg },
    Include = { ctermfg = cterm_colors.light_red },
    Repeat = { ctermfg = cterm_colors.light_red },
    Statement = { ctermfg = cterm_colors.light_red },
    Conditional = { link = "Statement" }, -- if, then, else, endif, switch, etc.
    Exception = { link = "Statement" },
    Label = { link = "Statement" }, -- case, default, etc.
    Keyword = { link = "None" },
    Operator = {}, -- "sizeof", "+", "*", etc.
    Function = { link = "None" }, -- function name (also: methods for classes) (both definitions and calls)
    Special = { ctermfg = cterm_colors.light_magenta },
    Todo = {},
    Done = {},

    -- Code Highlighting Extensions
    luaFunc = { link = "Function" },
    jsonKeyword = { link = "Identifier" },
    csAccess = { link = "None" },
    csNew = { link = "None" },
    csUnspecifiedStatement = { link = "None" },
    csUnsupportedStatement = { link = "None" },
    csUnspecifiedKeyword = { link = "None" },
    csLabel = { link = "None" }, -- matches to 'default' which is used in places other that switch statements
    csStorage = { link = "Type" },
    csXhtmlTag = { link = "None" },
    csXmlTag = { link = "Comment" },
    csXmlAttrib = { link = "Comment" },
    csClass = { link = "Type" },
    helpExample = { link = "None" },
    cssIdentifier = { link = "Identifier" },
    cssSelectorOp = { link = "None" },
    cssClassName = { link = "Type" },
    cssClassNameDot = { link = "Type" },
    cssSelectorOp1 = { link = "None" },
    cssAttrComma = { link = "None" },
    cssProp = { link = "None" },
    cssAttrRegion = { link = "Constant" },
    htmlTagN = { link = "htmlTagName" },
    htmlTagName = { link = "Type" },
    htmlSpecialTagName = { link = "Tag" },
    htmlEndTag = { link = "None" },
    htmlArg = { link = "Delimiter" },
    htmlError = { link = "None" },
    javascript = { link = "None" },
    javaConceptKind = { link = "Type" },
    shQuote = { link = "String" },
    docbkKeyword = { link = "Type" },
    xmlEntityPunct = { link = "Special" },
    xmlEntity = { link = "Special" },
    xmlAttrib = { link = "None" },
    rTransition = { link = "Statement" },
    ["@field"] = { link = "@property" },
    ["@constructor"] = { link = "Function" },
    ["@none"] = { link = "Normal" }, -- used for C# format strings
    ["@string"] = { link = "String" },
    ["@string.regex"] = { link = "String" },
    ["@string.escape"] = { link = "Special" },
    ["@string.special"] = { link = "String" },
    ["@string.special.url"] = { link = "String" },
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
    ["@parameter"] = { link = "None" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.directive"] = { link = "Statement" },
    ["@keyword.import"] = { link = "Statement" },
    ["@keyword.return"] = { link = "Statement" },
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
    ["@property.yaml"] = { link = "Identifier" },
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
    ["@markup.quote"] = { link = "String" },
    ["@markup.math"] = { link = "String" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.italic"] = { italic = config.italic },
    ["@markup.raw.block"] = { link = "@markup.raw" },
    ["@markup.list"] = { link = "Type" },
    ["@markup.list.checked"] = { link = "@markup.list" },
    ["@markup.list.unchecked"] = { link = "@markup.list" },
    ["Delimiter"] = {},
    ["@punctuation.special.c_sharp"] = { link = "@none" },

    -- Markdown
    mkdFootnotes = { link = "Constant" },
    htmlItalic = { link = "None", italic = config.italic },
    mkdRule = { link = "None" },
    mkdLink = { link = "Constant" },
    mkdUrl = { link = "Comment" },
    mkdInlineUrl = { link = "Constant" },
    markdownCode = { link = "Constant" },
    markdownEscape = { link = "None" },
    mkdLineBreak = { link = "None" },
    mkdID = { link = "Comment" },
    ["@keyword.directive.markdown"] = {},
    ["@punctuation.special.markdown"] = { link = "@punctuation" },
    ["@markup.link.markdown_inline"] = {},
    ["@markup.link.url.markdown"] = { link = "Comment" },
    ["@markup.link.url.markdown_inline"] = { link = "Comment" },
    ["@markup.link.label.markdown"] = { link = "Comment" },
    ["@markup.link.label.markdown_inline"] = { link = "Constant" },

    -- Clear html inline markup
    ["@markup.heading.html"] = {},
    ["@markup.heading.1.html"] = {},
    ["@markup.heading.2.html"] = {},
    ["@markup.heading.3.html"] = {},
    ["@markup.heading.4.html"] = {},
    ["@markup.heading.5.html"] = {},
    ["@markup.heading.6.html"] = {},
    ["@markup.strong.html"] = {},
    ["@markup.italic.html"] = {},
    ["@markup.underline.html"] = {},
    ["@markup.strikethrough.html"] = {},
    ["@markup.link.label.html"] = {},
    ["@markup.raw.html"] = {},

    -- Quickfix list
    QuickFixLine = { ctermfg = cterm_colors.light_magenta },
    QfFileName = { link = "None" },
    QfLineNr = { link = "None" },

    -- SQL
    ["@keyword.sql"] = { link = "Statement" },
    ["@type.sql"] = { link = "None" },
    ["@type.builtin.sql"] = { link = "None" },
    ["@attribute.sql"] = { link = "None" },

    -- Git diff files
    gitHead = { link = "Constant" },
    gitKeyword = { link = "Constant" },
    gitIdentity = { link = "Special" },
    gitIdentityKeyword = { link = "gitHead" },
    gitIdentityHeader = { link = "gitHead" },
    gitDateHeader = { link = "gitHead" },
    gitDate = { link = "Special" },
    gitEmail = { link = "Special" },
    gitEmailDelimiter = { link = "Special" },
    diffFile = { link = "Constant" },
    diffIndexLine = { link = "Constant" },
    diffOldFile = { link = "Constant" },
    diffNewFile = { link = "Constant" },
    diffLine = { link = "Comment" },
    diffSubname = { link = "Comment" },
    gitNotesHeader = { link = "gitKeyword" },
    gitReflogHeader = { link = "gitKeyword" },
    gitMode = { link = "Number" },
    gitHashStage = { link = "gitHash" },
    gitReflogOld = { link = "gitHash" },
    gitReflogNew = { link = "gitHash" },
    gitHash = { link = "Special" },
    gitHashAbbrev = { link = "GitHash" },
    gitReflogMiddle = { link = "gitReference" },
    gitReference = { link = "Function" },
    gitStage = { link = "gitType" },
    gitType = { link = "Type" },
    gitDiffAdded = { link = "diffAdded" },
    gitDiffRemoved = { link = "diffRemoved" },
}

vim.g.html_no_rendering = 1

vim.o.termguicolors = false
vim.o.background = "dark" -- prevents colors from being reset
for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
end
