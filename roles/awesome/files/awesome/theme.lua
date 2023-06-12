local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "Inter 10"

theme.bg_normal     = "#ffffff" -- white
theme.bg_focus      = "#d0d0d0" -- light gray
theme.bg_urgent     = "#b0b0b0" -- medium-light gray
theme.bg_minimize   = "#909090" -- medium gray
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#000000" -- black
theme.fg_focus      = "#404040" -- dark gray
theme.fg_urgent     = "#202020" -- very dark gray
theme.fg_minimize   = "#202020" -- very dark gray

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = "#000000" -- black
theme.border_focus  = "#000000" -- darker medium gray
theme.border_marked = "#000000" -- very dark gray

local taglist_square_size = dpi(5)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.menu_height   = dpi(30)
theme.menu_width    = dpi(150)

theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)
theme.icon_theme = nil

return theme