local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local naughty = require("naughty")

settings_ui = {}

-- settings popup
coldslider = wibox.widget({
    minimum = 0,
    maximum = 255,
    value = 150,
    handle_color = beautiful.bg_normal,
    handle_shape = gears.shape.circle,
    handle_border_color = beautiful.border_color,
    handle_border_width = 1,
    bar_shape = gears.shape.rounded_rect,
    bar_height = 3,
    bar_color = beautiful.border_color,
    forced_height = 50,
    forced_width = 200,
    widget = wibox.widget.slider
})

coldslider:connect_signal("property::value", function(maybe, new_value)
    naughty.notify({title = maybe.value, text = "changed"})
    awful.spawn("brightnessctl -d 'backlight_cold' s " .. maybe.value)
end)

warmslider = wibox.widget({
    minimum = 0,
    maximum = 255,
    value = 150,
    handle_color = beautiful.bg_normal,
    handle_shape = gears.shape.circle,
    handle_border_color = beautiful.border_color,
    handle_border_width = 1,
    bar_shape = gears.shape.rounded_rect,
    bar_height = 3,
    bar_color = beautiful.border_color,
    forced_height = 50,
    forced_width = 200,
    widget = wibox.widget.slider
})

warmslider:connect_signal("property::value", function(maybe, new_value)
    naughty.notify({title = maybe.value, text = "changed"})
    awful.spawn("brightnessctl -d 'backlight_warm' s " .. maybe.value)
end)

wifitoggle = wibox.widget({
    text = "Toggle",
    align = "center",
    widget = wibox.widget.textbox
})

wifitoggle:connect_signal("button::press", function()
    naughty.notify({title = "wifi toggle", text = "changed"})
    awful.spawn("sudo rfkill toggle 0")
end)

sleepbutton = wibox.widget({
    text = "Sleep",
    align = "center",
    widget = wibox.widget.textbox
})

sleepbutton:connect_signal("button::press", function()
    awful.spawn(gears.filesystem.get_configuration_dir() .. "scripts/suspend.sh")
end)

powerbutton = wibox.widget({
    text = "Poweroff",
    align = "center",
    widget = wibox.widget.textbox
})

powerbutton:connect_signal("button::press",
                           function() awful.spawn("sudo poweroff") end)

batterystatus = awful.widget.watch(gears.filesystem.get_configuration_dir() ..
                                       "scripts/battery.sh", 30)

pop = awful.popup({
    widget = {
        {
            {
                text = "Settings",
                align = "center",
                forced_width = 500,
                widget = wibox.widget.textbox
            },
            {
                {text = "Cold", widget = wibox.widget.textbox},
                coldslider,
                {text = "Warm", widget = wibox.widget.textbox},
                warmslider,
                {text = "WiFi", widget = wibox.widget.textbox},
                {
                    wifitoggle,

                    bg = "#ff00ff",
                    clip = true,
                    shape = gears.shape.rounded_bar,
                    widget = wibox.widget.background
                },
                {
                    powerbutton,
                    bg = "#ff00ff",
                    clip = true,
                    shape = gears.shape.rounded_bar,
                    widget = wibox.widget.background
                },

                {
                    sleepbutton,
                    bg = "#ff00ff",
                    clip = true,
                    shape = gears.shape.rounded_bar,
                    widget = wibox.widget.background
                },
                forced_num_cols = 2,
                forced_num_rows = 4,
                homogeneous = true,
                expand = true,
                spacing = 10,
                layout = wibox.layout.grid
            },
            {batterystatus, margins = 20, widget = wibox.container.margin},
            layout = wibox.layout.fixed.vertical
        },

        top = 20,
        left = 20,
        right = 20,
        height = 400,
        widget = wibox.container.margin
    },
    border_color = "#00ff00",
    border_width = 5,
    width = 300,
    placement = awful.placement.centered,
    shape = gears.shape.rounded_rect,
    visible = false,
    ontop = true
})

poptoggler = awful.widget.button({
    image = "/usr/share/icons/Adwaita/symbolic/categories/applications-system-symbolic.svg",
    buttons = {awful.button({}, 1, nil, function() end)}
})

poptoggler:connect_signal("button::press", function(c, _, _, button)
    pop.visible = not pop.visible
end)

settings_ui.pop = pop
settings_ui.poptoggler = poptoggler

return settings_ui
