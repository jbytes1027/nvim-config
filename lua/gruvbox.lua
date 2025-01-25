local Gruvbox = {}

Gruvbox.config = {
    undercurl = true,
    bold = true,
    inverse = true, -- invert background for search, diffs, statuslines and errors
}

-- main gruvbox color palette
---@class GruvboxPalette
Gruvbox.palette = {
    bg0 = "#282828",
    bg1 = "#3c3836",
    bg2 = "#504945",
    bg3 = "#665c54",
    bg4 = "#7c6f64",
    fg0 = "#fbf1c7",
    fg1 = "#ebdbb2",
    fg2 = "#d5c4a1",
    fg3 = "#bdae93",
    fg4 = "#a89984",
    light_red = "#fb4934",
    light_green = "#b8bb26",
    light_yellow = "#fabd2f",
    light_blue = "#83a598",
    light_purple = "#d3869b",
    light_aqua = "#8ec07c",
    light_orange = "#fe8019",
    dark_red = "#cc241d",
    dark_green = "#98971a",
    dark_yellow = "#d79921",
    dark_blue = "#458588",
    dark_purple = "#b16286",
    dark_aqua = "#689d6a",
    dark_orange = "#d65d0e",
    very_dark_red = "#722529",
    very_dark_green = "#444425",
    gray = "#928374",
}

local function get_groups()
    local colors = Gruvbox.palette
    local config = Gruvbox.config

    local groups = {
        GruvboxRedUnderline = { undercurl = config.undercurl, sp = colors.light_red },
        GruvboxGreenUnderline = { undercurl = config.undercurl, sp = colors.light_green },
        GruvboxYellowUnderline = { undercurl = config.undercurl, sp = colors.light_yellow },
        GruvboxBlueUnderline = { undercurl = config.undercurl, sp = colors.light_blue },
        GruvboxPurpleUnderline = { undercurl = config.undercurl, sp = colors.light_purple },
        GruvboxAquaUnderline = { undercurl = config.undercurl, sp = colors.light_aqua },
        SpellCap = { link = "GruvboxBlueUnderline" },
        SpellBad = { link = "GruvboxRedUnderline" },
        SpellLocal = { link = "GruvboxAquaUnderline" },
        SpellRare = { link = "GruvboxPurpleUnderline" },
        DiagnosticUnderlineError = { link = "GruvboxRedUnderline" },
        DiagnosticUnderlineWarn = { link = "GruvboxYellowUnderline" },
        DiagnosticUnderlineInfo = { link = "GruvboxBlueUnderline" },
        DiagnosticUnderlineHint = { link = "GruvboxAquaUnderline" },
        CmpItemAbbrMatchFuzzy = { link = "GruvboxBlueUnderline" },
    }

    return groups
end

--- main load function
Gruvbox.load = function()
    local groups = get_groups()

    -- add highlights
    for group, settings in pairs(groups) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return Gruvbox
