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
    AVG_PERIOD = 20,
    SPEED_UNIT = "m/s",
    ALTITUDE_UNIT = "m",
}

-- Instrument UI configuration
img_add_fullscreen("ls100_bg.png")
text_speed_unit = txt_add(S.SPEED_UNIT, " font:" .. G.FONT .. "; color:" .. G.COLOR_INVERTED .. ";  size:23; valign:center; halign: right;", 310, 440, 30, 23)
img_red_diamond = img_add("ls100_red_diamond.png", 0, 0, 512, 512)
img_vario_needle = img_add("ls100_vario_needle.png", 0, 0, 512, 512)

navbox_1_label = txt_add("", " font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 175, 150, 150, G.LABEL_SIZE)
navbox_1_value = txt_add("", " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:80; valign:center; halign: right;", 135, 165, 155, 80)
navbox_1_unit = txt_add("", " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: left;", 290, 205, 155, G.LABEL_SIZE)
navbox_2_label = txt_add("", " font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 175, 265, 155, G.LABEL_SIZE)
navbox_2_value = txt_add("", " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:80; valign:center; halign: right;", 135, 280, 155, 80)
navbox_2_unit = txt_add("", " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:" .. G.LABEL_SIZE .. "; valign:center; halign: left;", 290, 320, 155, G.LABEL_SIZE)

-- Wind
img_wind_arrow = img_add("ls100_wind_arrow.png", 130, 225, 35, 35)
navbox_wind_dir = txt_add("0°", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.LABEL_SIZE .. "; valign:center; halign: right;", 100, 265, 55, G.LABEL_SIZE)
txt_add("/", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.LABEL_SIZE .. "; valign:center; halign: left;", 155, 265, 35, G.LABEL_SIZE)
navbox_wind_velocity = txt_add("0", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.LABEL_SIZE .. "; valign:center; halign: left;", 165, 265, 35, G.LABEL_SIZE)

-- Altitude
txt_set(navbox_2_label, "Altitude")
txt_set(navbox_2_value, 0)
txt_set(navbox_2_unit, S.ALTITUDE_UNIT)

-- Vario (Total Energy)
txt_set(navbox_1_label, "Avg.vario")
txt_set(navbox_1_value, 0)
txt_set(navbox_1_unit, S.SPEED_UNIT)
avg_vario = 0
vario_history = {}

-- Netto Vario
avg_netto = 0
netto_history = {}

-- Functions --

-- Displays the wind direction in a arrow icon and in a textbox
-- @param velocity : the wind velocity in knots to be displayed in m/s to be displayed
-- @param direction : the wind direction in degrees
function display_wind(wind_direction, wind_velocity, plane_direction)

    plane_direction = var_round(180 / math.pi * plane_direction, 0)
    local direction =  wind_direction - plane_direction
    -- Rotating wind direction arrow
    rotate(img_wind_arrow, direction)

    -- Adding wind direction angle as text
    direction = string.format("%.0f°", wind_direction)
    txt_set(navbox_wind_dir, direction)

    -- Adding wind velocity
    wind_velocity = wind_velocity / 1.94 -- Converting knots to m/s
    wind_velocity = var_format(wind_velocity, 0)
    txt_set(navbox_wind_velocity, wind_velocity)
end

-- Writes the altitude in the 2nd textbox
-- @param altitude : the altitude in ft to be displayed in meters
function display_altitude(altitude)
    altitude = 3048 / 10000 * altitude
    altitude = var_cap(altitude, 0, 9999)
    altitude = var_format(altitude, 0)
    txt_set(navbox_2_value, altitude)
end

-- Computes the metric average withing the provided history and for the period set in "S.AVG_PERIOD"
-- @param metric_value : the latest metric value
-- @param history_table : the metric history table reference
function compute_avg_metric(metric_value, history_table)
    local sum = 0
    local array_size = 0
    local tuple = { metric_value, os.time() }
    table.insert(history_table, tuple)

    for index, value_tuple in pairs(history_table) do
        local now = os.time()
        local value = value_tuple[1]
        local value_time = value_tuple[2]
        if value_time < now - S.AVG_PERIOD then
            table.remove(history_table, index)
        else
            array_size = array_size + 1
            sum = sum + value
        end
    end
    return sum / array_size
end

-- Sets the orange needle to the total energy vario value and writes the avg. vario in the 1st textbox
-- @param vario : the latest total energy vario value
function dislay_vario(vario)
    local caped_vario = var_cap(vario, -5.0, 5.0)
    rotate(img_vario_needle, 240 / 10 * caped_vario)

    local avg_vario = 0
    avg_vario = compute_avg_metric(vario, vario_history)
    local op = ""
    if avg_vario > 0 then
        op = "+"
    end
    avg_vario = string.format("%s%.1f", op, avg_vario)
    txt_set(navbox_1_value, avg_vario)
end

-- Sets the red diamond to the avg. netto
-- @param netto : the latest netto value
function dislay_netto(netto)
    local avg_netto = 0
    avg_netto = compute_avg_metric(netto, netto_history)
    avg_netto = var_cap(avg_netto, -5.0, 5.0)
    rotate(img_red_diamond, 240 / 10 * avg_netto)
end

-- Subscriptions
fs2020_variable_subscribe("AMBIENT WIND DIRECTION","Degrees", "AMBIENT WIND VELOCITY", "Knots", "HEADING INDICATOR", "Radians", display_wind)

fs2020_variable_subscribe("L:NETTO", "FLOAT", dislay_netto)

fs2020_variable_subscribe("L:TOTAL ENERGY", "FLOAT", dislay_vario)

fs2020_variable_subscribe("PLANE ALTITUDE", "Feet", display_altitude)
