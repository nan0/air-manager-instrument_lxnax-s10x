-- Constants
DEFAULT_FONT = "roboto_regular.ttf"
DEFAULT_COLOR = "white"

-- Initialisations --
img_add_fullscreen("ls100_bg.png")
img_vario_needle = img_add("ls100_vario_needle.png", 0, 0, 512, 512) -- TODO: fetch canvas size from settings
-- img_maccready_needle = img_add("vario_neddle_VN.png", 0, 0, 512, 512) -- TODO: fetch canvas size from settings

textbox_altitude = txt_add("0", " font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR .. ";  size:80; valign:center; halign: right;", 140, 320, 155, 50)

img_wind_arrow = img_add("arrow_sm.png", 130, 245, 24, 33)
textbox_wind_dir = txt_add("0°", "font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR .. "; size:32; valign:center; halign: right;", 100, 280, 55, 35)

-- Functions --
function display_wind_direction(direction)
    -- Rotating wind direction arrow
    rotate(img_wind_arrow, direction)

    -- Adding wind direction angle as text
    direction = var_cap(direction, 0, 359)
    direction = string.format("%d°", direction)
    txt_set(textbox_wind_dir, direction)
end

function display_ground_altitude(altitude)
    ft_altitude = altitude * 328084 / 100000
    ft_altitude = var_cap(ft_altitude, 0, 9999)
    ft_altitude = var_format(ft_altitude, 0)
    txt_set(textbox_altitude, ft_altitude)
end

--[[ function dislay_vs(vs)
    vs = var_cap(vs, -1300, 1300)
    rotate(img_vario_needle, 180.0 / 2000 * vs)
end
]]--

function dislay_vario(vn)
    vn = var_cap(vn, -10.0, 10.0)
    rotate(img_vario_needle, 240 / 20.0 * vn)
end

-- Subscriptions
fsx_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", display_wind_direction)

fsx_variable_subscribe("GROUND ALTITUDE", "Meters", display_ground_altitude)

-- fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", dislay_vs)

fs2020_variable_subscribe("L:VARIO_NEEDLE", "FLOAT", dislay_vario)