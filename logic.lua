-- Global variables --


-- Images --
img_add_fullscreen("ls100_bg.png")

img_wind_arrow = img_add("arrow_sm.png", 130, 245, 24, 33)
img_vs_needle = img_add("vario_neddle_VS.png", 0, 0, 500, 500)
img_vn_needle = img_add("vario_neddle_VN.png",0, 0, 500, 500)

-- Functions --
function display_wind_direction(direction)
    local wind_dir_txt = txt_add("0°", "font:roboto_regular.ttf; color:white; size:32; valign:center; halign: right;", 100, 280, 55, 35)

    -- Rotating wind direction arrow
    rotate(img_wind_arrow, direction)
    
    -- Adding wind direction angle as text
    direction = var_cap(direction, 0, 359)
    direction = string.format("%d°", direction)
    txt_set(wind_dir_txt, direction)

end

function display_ground_altitude(altitude)
    local altitude_txt = txt_add("0", "font:roboto_regular.ttf; color:white; size:80; valign:center; halign: right;", 140, 320, 155, 50)

    ft_altitude = altitude * 328084 / 100000
    ft_altitude = var_cap(ft_altitude, 0, 9999)
    ft_altitude = var_format(ft_altitude, 0)
    txt_set(altitude_txt, ft_altitude)
end

function dislay_vs(vs)
    vs = var_cap(vs, -1300, 1300)
    rotate(img_vs_needle, 180.0 / 2000 * vs)
end

function dislay_vn(vn)
    vn = var_cap(vn, -10.0, 10.0)
    rotate(img_vn_needle, 180.0 / 20.0 * vn)
end

fsx_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", display_wind_direction)

fsx_variable_subscribe("GROUND ALTITUDE", "Meters", display_ground_altitude)

fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", dislay_vs)

fs2020_variable_subscribe("L:VARIO_NEEDLE", "FLOAT", dislay_vn)