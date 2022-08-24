
-- Instrument UI configuration
img_add_fullscreen("ls100_bg.png")
local textSpeedUnit = txt_add("m/s", " font:" .. G.FONT .. "; color:" .. G.COLOR_INVERTED .. ";  size:23;  halign: right;", 310, 440, 30, 23)
local imgRedDiamond = img_add("ls100_red_diamond.png", 0, 0, 512, 512)
local imgVarioNeedle = img_add("ls100_vario_needle.png", 0, 0, 512, 512)

-- Wind "Box"
local imgWindArrow = img_add("ls100_wind_arrow.png", 120, 225, 35, 35)
local navboxWindDir = txt_add("0°", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: right;", 90, 265, 55, G.TEXT_SIZE)
txt_add("/", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: left;", 145, 265, 35, G.TEXT_SIZE)
local navboxWindVelocity = txt_add("0", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: left;", 155, 265, 35, G.TEXT_SIZE)

-- Navbox Vario (Total Energy)
local navbox1 = Navbox.new(1, "Avg.vario", 0)
local avgVario = 0
local vario_history = {}

-- Navbox Netto
local navbox2 = Navbox.new(2, "Netto", 0)
local avgNetto = 0
local nettoHistory = {}

-- Navbox Altitude
local navbox3 = Navbox.new(3, "Altitude", 0)

-- Navbox TAS
local navbox4 = Navbox.new(4, "TAS", 0)


-- Displays the wind direction in a arrow icon and in a textbox
-- @param velocity : the wind velocity in knots to be displayed in m/s
-- @param direction : the wind direction in degrees
function displayWind(windDirection, windVelocity, planeDirection)
    planeDirection = var_round(180 / math.pi * planeDirection, 0)
    local direction = windDirection - planeDirection
    rotate(imgWindArrow, direction)

    direction = string.format("%.0f°", windDirection)
    txt_set(navboxWindDir, direction)

    windVelocity = windVelocity / 1.94 -- Converting knots to m/s
    windVelocity = var_format(windVelocity, 0)
    txt_set(navboxWindVelocity, windVelocity)
end

-- Sets the orange needle to the total energy vario value and writes the avg. vario in the 1st navbox
-- @param vario : the latest total energy vario value
function dislayVario(vario)
    local capedVario = var_cap(vario, -5.0, 5.0)
    rotate(imgVarioNeedle, 240 / 10 * capedVario)

    local avgVario = 0
    avgVario = computeAvgMetric(vario, vario_history, S_AVG_VARIO_TIME)
    avgVario = prependPlus(avgVario)
    avgVario = string.format("%.1f", avgVario)
    navbox1.setValue(avgVario, "m/s")
end

-- Sets the red diamond to the avg. netto and writes the current netto in the 2nd navbox
-- @param netto : the latest netto value
function displayNetto(netto)
    local avgNetto = 0
    avgNetto = computeAvgMetric(netto, nettoHistory, S_AVG_NETTO_TIME)
    avgNetto = var_cap(avgNetto, -5.0, 5.0)
    rotate(imgRedDiamond, 240 / 10 * avgNetto)

    netto = prependPlus(netto)
    netto = string.format("%.1f", netto)
    navbox2.setValue(netto, "m/s")
end

-- Writes the altitude in the 3rd navbox
-- @param altitude : the altitude in ft to be displayed in meters
function displayAltitude(altitude)
    altitude = 3048 / 10000 * altitude
    altitude = var_cap(altitude, 0, 9999)
    altitude = var_format(altitude, 0)
    navbox3.setValue(altitude, "m")
end

-- Writes the TAS in the 4th navbox
-- @param tas : the tas in knots to be diplayed in km/h
function displayAirspeed(tas)
    tas = tas * 1852 / 1000 --converting to km/h
    tas = var_cap(tas, 0, 9999)
    tas = string.format("%.0f", tas)
    navbox4.setValue(tas, "km/h")
end

-- Subscriptions
fs2020_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", "AMBIENT WIND VELOCITY", "Knots", "HEADING INDICATOR", "Radians", displayWind)
fs2020_variable_subscribe("L:NETTO", "FLOAT", displayNetto)
fs2020_variable_subscribe("L:TOTAL ENERGY", "FLOAT", dislayVario)
fs2020_variable_subscribe("PLANE ALTITUDE", "Feet", displayAltitude)
fs2020_variable_subscribe("AIRSPEED TRUE", "Knots", displayAirspeed)
