-- Global constants
G = {
    FONT = "roboto_regular.ttf",
    COLOR_PRIMARY = "white",
    COLOR_SECONDARY = "#c2c4c2",
    COLOR_INVERTED = "black",
    LABEL_SIZE = 28,
}

-- Instrument settings
S = {
    AVG_VARIO_PERIOD = 20,
    VARIO_UNIT = "m/s",
    ALTITUDE_UNIT = "m",
}

-- Background
img_add_fullscreen("ls100_bg.png")
img_vario_unit = txt_add(S.VARIO_UNIT, " font:" .. G.FONT .. "; color:" .. G.COLOR_INVERTED .. ";  size:23; valign:center; halign: right;", 310, 440, 30, 23)

-- Vario
txt_add("Avg.vario", " font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 175, 150, 150, G.LABEL_SIZE)
txt_add(S.VARIO_UNIT, " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 175, 205, 155, G.LABEL_SIZE)
textbox_avg_vario = txt_add("0", " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:80; valign:center; halign: right;", 135, 165, 155, 80)
img_vario_needle = img_add("ls100_vario_needle.png", 0, 0, 512, 512)
avg_vario = 0
last_vario_values = {}


-- Altitude
txt_add("Altitude", " font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 175, 265, 155, G.LABEL_SIZE)
txt_add(S.ALTITUDE_UNIT, " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 175, 320, 155, G.LABEL_SIZE)
textbox_altitude = txt_add("0", " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:80; valign:center; halign: right;", 160, 280, 155, 80)

-- Wind
img_wind_arrow = img_add("ls100_wind_arrow.png", 130, 225, 35, 35)
textbox_wind_dir = txt_add("0°", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 100, 265, 55, G.LABEL_SIZE)
txt_add("/", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.LABEL_SIZE .. "; valign:center; halign: left;", 155, 265, 35, G.LABEL_SIZE)
textbox_wind_velocity = txt_add("0", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.LABEL_SIZE .. "; valign:center; halign: left;", 165, 265, 35, G.LABEL_SIZE)

-- Functions --

-- Displays the wind direction in a arrow icon and in a textbox
-- @param direction : the wind direction in degrees
function display_wind_direction(direction)
    -- Rotating wind direction arrow
    rotate(img_wind_arrow, direction)

    -- Adding wind direction angle as text
    direction = var_cap(direction, 0, 359)
    direction = string.format("%f°", direction)
    txt_set(textbox_wind_dir, direction)
end

-- Displays the wind velocity in a textbox
-- @param velocity : the wind velocity in m/s to be displayed
function display_wind_velocity(velocity)
    velocity = var_format(velocity, 0)
    txt_set(textbox_wind_velocity, velocity)
end

-- Displays the ground altitude in a textbox
-- @param altitude : the altitude in meters to be displayed as is
function display_ground_altitude(altitude)
    altitude = var_cap(altitude, 0, 9999)
    altitude = var_format(altitude, 0)
    txt_set(textbox_altitude, altitude)
end

-- Computes the vario average for the period set in "avg_vario_period"
-- @param vn : the latest vario value
function compute_avg_vario(vn)
    local sum = 0
    local array_size = 0
    local tuple = { vn, os.time() }
    table.insert(last_vario_values, tuple)
    for index, value_tuple in pairs(last_vario_values) do
        local now = os.time()
        local value = value_tuple[1]
        local value_time = value_tuple[2]
        if value_time < now - S.AVG_VARIO_PERIOD then
            table.remove(last_vario_values, index)
        else
            array_size = array_size + 1
            sum = sum + value
        end
    end
    return sum / array_size
end

-- Makes the red needle display the vario
-- @param vn : the latest vario value
function dislay_vario(vn)
    local avg_vario = 0
    local needle_vn = var_cap(vn, -5.0, 5.0)
    rotate(img_vario_needle, 240 / 10 * needle_vn)

    avg_vario = compute_avg_vario(vn)
    avg_vario = var_round(avg_vario, 1)
    local op = ""
    if avg_vario > 0 then
        op = "+"
    end
    local formated_str = string.format("%s%.1f", op, avg_vario)
    txt_set(textbox_avg_vario, formated_str)
end

-- Subscriptions
fs2020_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", display_wind_direction)

fs2020_variable_subscribe("AMBIENT WIND VELOCITY", "Knots", display_wind_velocity)

fs2020_variable_subscribe("GROUND ALTITUDE", "Meters", display_ground_altitude)

fs2020_variable_subscribe("L:VARIO_NEEDLE", "FLOAT", dislay_vario)