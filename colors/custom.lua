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
    TabLineFill = { ctermfg = cterm_colors.dark_fg, ctermbg = cterm_colors.dark_bg, reverse = config.invert_tabline },
    TabLineSel = { ctermfg = cterm_colors.light_green, ctermbg = cterm_colors.dark_bg, reverse = config.invert_tabline },
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
    StatusLine = { ctermfg = cterm_colors.light_fg, ctermbg = cterm_colors.light_bg },
    StatusLineNC = { ctermfg = cterm_colors.dark_fg, ctermbg = cterm_colors.light_bg },
    WinSeparator = { ctermfg = cterm_colors.light_bg, ctermbg = cterm_colors.dark_bg },
    WildMenu = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.light_bg, bold = config.bold },
    ErrorMsg = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.light_red, bold = config.bold },
    MoreMsg = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    ModeMsg = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    Question = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    WarningMsg = { ctermfg = cterm_colors.light_red, bold = config.bold },
    SignColumn = { ctermbg = cterm_colors.dark_bg },
    Folded = { ctermfg = cterm_colors.dark_fg, ctermbg = cterm_colors.light_bg, italic = true },
    FoldColumn = { ctermfg = cterm_colors.dark_fg, ctermbg = cterm_colors.dark_bg },
    Cursor = { ctermbg = cterm_colors.light_fg },
    Error = { ctermfg = cterm_colors.light_red, bold = config.bold, reverse = true },
    vCursor = { link = "Cursor" },
    iCursor = { link = "Cursor" },
    lCursor = { link = "Cursor" },
    CursorLine = { ctermbg = cterm_colors.light_bg },
    CursorColumn = { link = "CursorLine" },
    CursorLineNr = { ctermbg = cterm_colors.light_bg },
    Cursor = { ctermbg = cterm_colors.light_fg },
    Pmenu = { ctermfg = cterm_colors.light_fg, ctermbg = cterm_colors.light_bg },
    PmenuSel = { ctermfg = cterm_colors.light_bg, ctermbg = cterm_colors.light_blue, bold = config.bold },
    PmenuSbar = { ctermbg = cterm_colors.light_bg },
    PmenuThumb = { ctermbg = cterm_colors.dark_fg },
    DiagnosticError = { ctermfg = cterm_colors.light_red },
    DiagnosticSignError = {
        ctermfg = cterm_colors.light_red,
        ctermbg = cterm_colors.dark_bg,
        reverse = config.invert_signs,
    },
    DiagnosticWarn = { ctermfg = cterm_colors.light_yellow },
    DiagnosticSignWarn = {
        ctermfg = cterm_colors.light_green,
        ctermbg = cterm_colors.dark_bg,
        reverse = config.invert_signs,
    },
    DiagnosticInfo = { ctermfg = cterm_colors.light_blue },
    DiagnosticSignInfo = {
        ctermfg = cterm_colors.light_blue,
        ctermbg = cterm_colors.dark_bg,
        reverse = config.invert_signs,
    },
    DiagnosticHint = { ctermfg = cterm_colors.light_cyan },
    DiagnosticSignHint = {
        ctermfg = cterm_colors.light_aqua,
        ctermbg = cterm_colors.dark_bg,
        reverse = config.invert_signs,
    },
    DiffDelete = { ctermbg = cterm_colors.dark_red, ctermfg = cterm_colors.dark_red },
    DiffAdd = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    DiffChange = {},
    DiffText = { ctermbg = cterm_colors.dark_green, ctermfg = cterm_colors.dark_bg },
    diagnosticvirtualtexterror = { ctermbg = cterm_colors.light_red, ctermfg = cterm_colors.dark_bg, bold = true },
    diagnosticvirtualtextwarn = { ctermbg = cterm_colors.light_yellow, ctermfg = cterm_colors.dark_bg, bold = true },
    diagnosticvirtualtextinfo = { ctermbg = cterm_colors.light_blue, ctermfg = cterm_colors.dark_bg, bold = true },
    diagnosticvirtualtexthint = { ctermbg = cterm_colors.light_aqua, ctermfg = cterm_colors.dark_bg, bold = true },
    diagnosticok = { ctermfg = cterm_colors.light_green, ctermbg = cterm_colors.dark_bg, reverse = config.invert_signs },
    LspReferenceRead = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    LspReferenceText = { ctermfg = cterm_colors.light_yellow, bold = config.bold },
    LspReferenceWrite = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    LspCodeLens = { ctermfg = cterm_colors.light_bg },
    LspSignatureActiveParameter = { link = "Search" },
    gitcommitSelectedFile = { ctermfg = cterm_colors.light_green },
    gitcommitDiscardedFile = { ctermfg = cterm_colors.light_red },
    GitSignsAdd = { ctermfg = cterm_colors.light_green },
    GitSignsChange = { ctermfg = cterm_colors.light_blue },
    GitSignsDelete = { ctermfg = cterm_colors.light_red },
    GitSignsAddNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_green },
    GitSignsChangeNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_green },
    GitSignsDeleteNr = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_red },
    debugPC = { ctermbg = cterm_colors.light_blue },
    DirvishPathTail = { ctermfg = cterm_colors.light_cyan },
    DirvishArg = { ctermfg = cterm_colors.light_yellow },
    netrwDir = { ctermfg = cterm_colors.light_cyan },
    netrwClassify = { ctermfg = cterm_colors.light_cyan },
    netrwLink = { ctermfg = cterm_colors.light_bg },
    netrwSymLink = { ctermfg = cterm_colors.light_fg },
    netrwExe = { ctermfg = cterm_colors.light_yellow },
    netrwComment = { ctermfg = cterm_colors.light_bg },
    netrwList = { ctermfg = cterm_colors.light_blue },
    netrwHelpCmd = { ctermfg = cterm_colors.light_cyan },
    netrwVersion = { ctermfg = cterm_colors.light_green },
    TelescopeNormal = { ctermfg = cterm_colors.light_fg },
    TelescopeSelection = { ctermfg = cterm_colors.light_magenta, bold = config.bold },
    TelescopeSelectionCaret = { ctermfg = cterm_colors.light_red },
    TelescopeMultiSelection = { ctermfg = cterm_colors.light_bg },
    TelescopeBorder = { link = "TelescopeNormal" },
    TelescopePromptBorder = { link = "TelescopeNormal" },
    TelescopeResultsBorder = { link = "TelescopeNormal" },
    TelescopePreviewBorder = { link = "TelescopeNormal" },
    TelescopeMatching = { ctermfg = cterm_colors.light_blue },
    TelescopePromptPrefix = { ctermfg = cterm_colors.light_red },
    TelescopePrompt = { link = "TelescopeNormal" },
    CmpItemAbbrDeprecated = { ctermfg = cterm_colors.light_fg },
    CmpItemAbbrMatch = { ctermfg = cterm_colors.light_blue, bold = config.bold },
    CmpItemMenu = { ctermfg = cterm_colors.light_bg },
    CmpItemKindText = { ctermfg = cterm_colors.dark_fg },
    CmpItemKindVariable = { ctermfg = cterm_colors.light_green },
    CmpItemKindMethod = { ctermfg = cterm_colors.light_blue },
    CmpItemKindFunction = { ctermfg = cterm_colors.light_blue },
    CmpItemKindConstructor = { ctermfg = cterm_colors.light_yellow },
    CmpItemKindUnit = { ctermfg = cterm_colors.light_blue },
    CmpItemKindField = { ctermfg = cterm_colors.light_blue },
    CmpItemKindClass = { ctermfg = cterm_colors.light_yellow },
    CmpItemKindInterface = { ctermfg = cterm_colors.light_yellow },
    CmpItemKindModule = { ctermfg = cterm_colors.light_blue },
    CmpItemKindProperty = { ctermfg = cterm_colors.light_blue },
    CmpItemKindValue = { ctermfg = cterm_colors.dark_fg },
    CmpItemKindEnum = { ctermfg = cterm_colors.light_yellow },
    CmpItemKindOperator = { ctermfg = cterm_colors.light_yellow },
    CmpItemKindKeyword = { ctermfg = cterm_colors.light_magenta },
    CmpItemKindEvent = { ctermfg = cterm_colors.light_magenta },
    CmpItemKindReference = { ctermfg = cterm_colors.light_magenta },
    CmpItemKindColor = { ctermfg = cterm_colors.light_magenta },
    CmpItemKindSnippet = { ctermfg = cterm_colors.light_green },
    CmpItemKindFile = { ctermfg = cterm_colors.light_blue },
    CmpItemKindFolder = { ctermfg = cterm_colors.light_blue },
    CmpItemKindEnumMember = { ctermfg = cterm_colors.light_cyan },
    CmpItemKindConstant = { ctermfg = cterm_colors.light_blue },
    CmpItemKindStruct = { ctermfg = cterm_colors.light_yellow },
    CmpItemKindTypeParameter = { ctermfg = cterm_colors.light_yellow },
    NavicIconsFile = { ctermfg = cterm_colors.light_blue },
    NavicIconsModule = { ctermfg = cterm_colors.light_green },
    NavicIconsNamespace = { ctermfg = cterm_colors.light_blue },
    NavicIconsPackage = { ctermfg = cterm_colors.light_cyan },
    NavicIconsClass = { ctermfg = cterm_colors.light_yellow },
    NavicIconsMethod = { ctermfg = cterm_colors.light_blue },
    NavicIconsProperty = { ctermfg = cterm_colors.light_cyan },
    NavicIconsField = { ctermfg = cterm_colors.light_magenta },
    NavicIconsConstructor = { ctermfg = cterm_colors.light_blue },
    NavicIconsEnum = { ctermfg = cterm_colors.light_magenta },
    NavicIconsInterface = { ctermfg = cterm_colors.light_green },
    NavicIconsFunction = { ctermfg = cterm_colors.light_blue },
    NavicIconsVariable = { ctermfg = cterm_colors.light_magenta },
    NavicIconsConstant = { ctermfg = cterm_colors.light_blue },
    NavicIconsString = { ctermfg = cterm_colors.light_green },
    NavicIconsNumber = { ctermfg = cterm_colors.light_blue },
    NavicIconsBoolean = { ctermfg = cterm_colors.light_blue },
    NavicIconsArray = { ctermfg = cterm_colors.dark_fg },
    NavicIconsObject = { ctermfg = cterm_colors.dark_fg },
    NavicIconsKey = { ctermfg = cterm_colors.light_cyan },
    NavicIconsNull = { ctermfg = cterm_colors.light_blue },
    NavicIconsEnumMember = { ctermfg = cterm_colors.light_yellow },
    NavicIconsStruct = { ctermfg = cterm_colors.light_magenta },
    NavicIconsEvent = { ctermfg = cterm_colors.light_yellow },
    NavicIconsOperator = { ctermfg = cterm_colors.light_red },
    NavicIconsTypeParameter = { ctermfg = cterm_colors.light_red },
    NavicText = { ctermfg = cterm_colors.light_fg },
    NavicSeparator = { ctermfg = cterm_colors.light_fg },
    TargetWord = { ctermfg = cterm_colors.light_blue, bold = config.bold },
    FinderSeparator = { ctermfg = cterm_colors.light_cyan },
    MasonHighlight = { ctermfg = cterm_colors.light_cyan },
    MasonHighlightBlock = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.light_blue },
    MasonHighlightBlockBold = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.light_blue, bold = true },
    MasonHighlightSecondary = { ctermfg = cterm_colors.light_yellow },
    MasonHighlightBlockSecondary = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.light_yellow },
    MasonHighlightBlockBoldSecondary = {
        ctermfg = cterm_colors.dark_bg,
        ctermbg = cterm_colors.light_yellow,
        bold = true,
    },
    MasonHeader = { link = "MasonHighlightBlockBoldSecondary" },
    MasonHeaderSecondary = { link = "MasonHighlightBlock", bold = config.bold },
    MasonMuted = { ctermfg = cterm_colors.dark_fg },
    MasonMutedBlock = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_fg },
    MasonMutedBlockBold = { ctermfg = cterm_colors.dark_bg, ctermbg = cterm_colors.dark_fg, bold = true },
    NotifyDEBUGBorder = { ctermfg = cterm_colors.light_blue },
    NotifyDEBUGIcon = { ctermfg = cterm_colors.light_blue },
    NotifyDEBUGTitle = { ctermfg = cterm_colors.light_blue },
    NotifyERRORBorder = { ctermfg = cterm_colors.light_red },
    NotifyERRORIcon = { ctermfg = cterm_colors.light_red },
    NotifyERRORTitle = { ctermfg = cterm_colors.light_red },
    NotifyINFOBorder = { ctermfg = cterm_colors.light_cyan },
    NotifyINFOIcon = { ctermfg = cterm_colors.light_cyan },
    NotifyINFOTitle = { ctermfg = cterm_colors.light_cyan },
    NotifyTRACEBorder = { ctermfg = cterm_colors.light_green },
    NotifyTRACEIcon = { ctermfg = cterm_colors.light_green },
    NotifyTRACETitle = { ctermfg = cterm_colors.light_green },
    NotifyWARNBorder = { ctermfg = cterm_colors.light_yellow },
    NotifyWARNIcon = { ctermfg = cterm_colors.light_yellow },
    NotifyWARNTitle = { ctermfg = cterm_colors.light_yellow },
    IlluminatedWordText = { link = "LspReferenceText" },
    IlluminatedWordRead = { link = "LspReferenceRead" },
    IlluminatedWordWrite = { link = "LspReferenceWrite" },
    DapBreakpointSymbol = { ctermfg = cterm_colors.light_red, ctermbg = cterm_colors.dark_bg },
    DapStoppedSymbol = { ctermfg = cterm_colors.light_green, ctermbg = cterm_colors.dark_bg },
    DapUIBreakpointsCurrentLine = { ctermfg = cterm_colors.light_yellow },
    DapUIBreakpointsDisabledLine = { ctermfg = cterm_colors.light_bg },
    DapUIBreakpointsInfo = { ctermfg = cterm_colors.light_cyan },
    DapUIBreakpointsLine = { ctermfg = cterm_colors.light_yellow },
    DapUIBreakpointsPath = { ctermfg = cterm_colors.light_blue },
    DapUICurrentFrameName = { ctermfg = cterm_colors.light_magenta },
    DapUIDecoration = { ctermfg = cterm_colors.light_magenta },
    DapUIFloatBorder = { ctermfg = cterm_colors.light_cyan },
    DapUILineNumber = { ctermfg = cterm_colors.light_yellow },
    DapUIModifiedValue = { ctermfg = cterm_colors.light_red },
    DapUIPlayPause = { ctermfg = cterm_colors.light_green, ctermbg = cterm_colors.dark_bg },
    DapUIRestart = { ctermfg = cterm_colors.light_green, ctermbg = cterm_colors.dark_bg },
    DapUIScope = { ctermfg = cterm_colors.light_blue },
    DapUISource = { ctermfg = cterm_colors.light_fg },
    DapUIStepBack = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.dark_bg },
    DapUIStepInto = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.dark_bg },
    DapUIStepOut = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.dark_bg },
    DapUIStepOver = { ctermfg = cterm_colors.light_blue, ctermbg = cterm_colors.dark_bg },
    DapUIStop = { ctermfg = cterm_colors.light_red, ctermbg = cterm_colors.dark_bg },
    DapUIStoppedThread = { ctermfg = cterm_colors.light_blue },
    DapUIThread = { ctermfg = cterm_colors.light_blue },
    DapUIType = { ctermfg = cterm_colors.light_green },
    DapUIUnavailable = { ctermfg = cterm_colors.light_bg },
    DapUIWatchesEmpty = { ctermfg = cterm_colors.light_bg },
    DapUIWatchesError = { ctermfg = cterm_colors.light_red },
    DapUIWatchesValue = { ctermfg = cterm_colors.light_yellow },
    DapUIWinSelect = { ctermfg = cterm_colors.light_yellow },
    NeogitDiffDelete = { link = "DiffDelete" },
    NeogitDiffAdd = { link = "DiffAdd" },
    NeogitHunkHeader = { link = "WinBar" },
    NeogitHunkHeaderHighlight = { link = "WinBarNC" },
    LspInlayHint = { link = "comment" },

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
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@function.macro"] = { link = "Function" },
    ["@method"] = { link = "Function" },
    ["@parameter"] = {},
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.operator"] = { link = "Operator" },
    ["@conditional"] = { link = "Conditional" },
    ["@repeat"] = { link = "Repeat" },
    ["@debug"] = { link = "Debug" },
    ["@label"] = { link = "Label" },
    ["@include"] = { link = "Include" },
    ["@exception"] = { link = "Exception" },
    ["@type"] = { link = "Type" },
    ["@attribute"] = { link = "Attribute" },
    ["@variable"] = {},
    ["@constant.builtin"] = { link = "Constant" },
    ["@text.literal"] = { link = "String" },
    ["@tag"] = { link = "Tag" },
    ["@property"] = {}, -- class properties and lhs of json properties
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
    ["Delimiter"] = {},
}

vim.o.background = "dark" -- prevents colors from being reset
for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
end