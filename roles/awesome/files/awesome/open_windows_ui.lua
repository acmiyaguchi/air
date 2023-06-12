local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Define our OpenWindows object
OpenWindows = {}
OpenWindows.__index = OpenWindows

-- Constructor
function OpenWindows.new()
    local self = setmetatable({}, OpenWindows)
    self.widget = wibox.widget({
        layout = wibox.layout.fixed.vertical,
    })
    self.popup = awful.popup {
        widget = self.widget,
        border_color = "#00ff00",
        border_width = 5,
        width = 500,
        placement = awful.placement.centered,
        shape = gears.shape.rounded_rect,

        visible = false,
        ontop = true
    }
    awesome.connect_signal("open_windows::toggle", function()
        self.popup.visible = not self.popup.visible
        if self.popup.visible then
            self:update_widget()
        end
    end)
    return self
end

-- Get open windows
function OpenWindows:get_open_windows()
    local open_windows = {}

    -- Iterate over all clients.
    for _, c in ipairs(client.get()) do
        -- Add to open_windows array.
        -- TODO: should this be configurable?
        if c.class == "svkbd" then
            -- Do nothing
        else
            table.insert(open_windows, {
                window = c,
                pid = c.pid,
                class = c.class,
                name = c.name,
                kill_button = wibox.widget {
                    {
                        widget = wibox.widget.textbox,
                        text = 'Kill',
                    },
                    shape = gears.shape.rounded_bar,
                    widget = wibox.container.background,
                    bg = '#ff0000',
                    buttons = gears.table.join(
                        awful.button({}, 1, function()
                            c:kill()
                        end)
                    )
                }
            })
        end
    end

    return open_windows
end

-- Update widget
function OpenWindows:update_widget()
    -- Clear widget
    self.widget:reset()
    local open_windows = self:get_open_windows()

    -- Create a row for each open window.
    for _, w in ipairs(open_windows) do
        local row = wibox.widget {
            {
                {
                    id = 'class',
                    widget = wibox.widget.textbox,
                    text = w.class,
                },
                {
                    id = 'name',
                    widget = wibox.widget.textbox,
                    text = w.name,
                },
                {
                    id = 'pid',
                    widget = wibox.widget.textbox,
                    text = tostring(w.pid),
                },
                spacing = 10,
                layout = wibox.layout.fixed.horizontal,
            },
            w.kill_button,
            spacing = 10,
            layout = wibox.layout.fixed.horizontal,
        }
        self.widget:add(row)
    end
end


return OpenWindows