-- Constants
DEFAULT_FONT = "roboto_regular.ttf"
DEFAULT_COLOR = "white"
COLOR_SECONDARY = "#c2c4c2"
DEFAULT_COLOR_INVERTED = "black"
DEFAULT_LABEL_SIZE = 28

-- Background
img_add_fullscreen("ls100_bg.png")
img_vario_unit = txt_add("m/s", " font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR_INVERTED .. ";  size:23; valign:center; halign: right;", 310, 440, 30, 23)

-- Altitude
txt_add("Altitude", " font:" .. DEFAULT_FONT .. "; color:" .. COLOR_SECONDARY .. ";  size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: right;", 175, 150, 155, DEFAULT_LABEL_SIZE)
txt_add("ft", " font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR .. ";  size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: right;", 175, 205, 155, DEFAULT_LABEL_SIZE)
textbox_altitude = txt_add("0", " font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR .. ";  size:80; valign:center; halign: right;", 160, 165, 155, 80)

-- Vario
txt_add("Variometer", " font:" .. DEFAULT_FONT .. "; color:" .. COLOR_SECONDARY .. ";  size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: right;", 175, 265, 150, DEFAULT_LABEL_SIZE)
txt_add("m/s", " font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR .. ";  size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: right;", 175, 320, 155, DEFAULT_LABEL_SIZE)
textbox_vario = txt_add("0", " font:" .. DEFAULT_FONT .. "; color:" .. DEFAULT_COLOR .. ";  size:80; valign:center; halign: right;", 135, 280, 155, 80)
img_vario_needle = img_add("ls100_vario_needle.png", 0, 0, 512, 512) -- TODO: fetch canvas size from settings

-- Wind
img_wind_arrow = img_add("ls100_wind_arrow.png", 130, 225, 35, 35)
textbox_wind_dir = txt_add("0°", "font:" .. DEFAULT_FONT .. "; color:" .. COLOR_SECONDARY .. ";size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: right;", 100, 265, 55, DEFAULT_LABEL_SIZE)
txt_add("/", "font:" .. DEFAULT_FONT .. "; color:" .. COLOR_SECONDARY .. ";size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: left;", 155, 265, 35, DEFAULT_LABEL_SIZE)
textbox_wind_velocity = txt_add("0", "font:" .. DEFAULT_FONT .. "; color:" .. COLOR_SECONDARY .. ";size:" .. DEFAULT_LABEL_SIZE .. "; valign:center; halign: left;", 165, 265, 35, DEFAULT_LABEL_SIZE)

-- Functions --
function display_wind_direction(direction)
    -- Rotating wind direction arrow
    rotate(img_wind_arrow, direction)

    -- Adding wind direction angle as text
    direction = var_cap(direction, 0, 359)
    direction = string.format("%d°", direction)
    txt_set(textbox_wind_dir, direction)
end

function display_wind_velocity(velocity)
    velocity = string.format("%d", velocity)
    txt_set(textbox_wind_velocity, velocity)
end

function display_ground_altitude(altitude)
    local ft_altitude = altitude * 328084 / 100000
    ft_altitude = var_cap(ft_altitude, 0, 9999)
    ft_altitude = var_format(ft_altitude, 0)
    txt_set(textbox_altitude, ft_altitude)
end

function dislay_vario(vn)
    local needle_vn = var_cap(vn, -5.0, 5.0)
    rotate(img_vario_needle, 240 / 10 * needle_vn)

    vn = var_round(vn, 1)
    local op = ""
    if vn > 0 then
        op = "+"
    end
    local formated_str = string.format("%s%.1f", op, vn)
    txt_set(textbox_vario, formated_str)
end

-- Subscriptions
fsx_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", display_wind_direction)

fsx_variable_subscribe("AMBIENT WIND VELOCITY", "Knots", display_wind_velocity)

fsx_variable_subscribe("GROUND ALTITUDE", "Meters", display_ground_altitude)

fs2020_variable_subscribe("L:VARIO_NEEDLE", "FLOAT", dislay_vario)