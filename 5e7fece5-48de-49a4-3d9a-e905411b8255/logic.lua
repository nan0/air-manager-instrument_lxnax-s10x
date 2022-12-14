local vario = Vario.new()
varioHistory = History.new(S_AVG_VARIO_TIME)
nettoHistory = History.new(S_AVG_NETTO_TIME)

-- Displays the wind direction in a arrow icon and in a textbox
-- @param windDirection : the wind velocity in degrees
-- @param windVelocity : the wind velocity in knots to be displayed in m/s
-- @param planeDirection : the plane direction in radians
function displayWind(windDirection, windVelocity, planeDirection)
    vario.windbox.setWindDirection(windDirection)

    planeDirection = var_round(180 / math.pi * planeDirection, 0)
    local direction = windDirection - planeDirection
    vario.windbox.setRelativeDirection(direction)

    windVelocity = windVelocity / 1.94 -- Converting knots to m/s
    windVelocity = var_format(windVelocity, 0)
    vario.windbox.setVelocity(windVelocity)
end

-- Sets the orange needle to the total energy vario value, writes the avg. vario in the 1st navbox and displays the min/max vario in the yellow line
-- @param vario : the latest total energy vario value
function dislayVario(totalEnergy)
    vario.needle.setValue(totalEnergy)

    avgVario = varioHistory.addAndCompute(totalEnergy).getAvg()
    avgVario = prependPlus(avgVario)
    avgVario = string.format("%.1f", avgVario)
    vario.navboxAvgVario.setValue(avgVario)
    vario.yellowBar.setValue(varioHistory.getMin(), varioHistory.getMax())
end

-- Sets the red diamond to the avg. netto and writes the current netto in the 2nd navbox
-- @param netto : the latest netto value
function displayNetto(netto)
    local avgNetto = 0
    avgNetto = nettoHistory.addAndCompute(netto).getAvg()
    vario.redDiamond.setValue(avgNetto)

    netto = prependPlus(netto)
    netto = string.format("%.1f", netto)
    vario.navboxNetto.setValue(netto)
end

-- Writes the altitude in the 3rd navbox
-- @param altitude : the altitude in ft to be displayed in meters
function displayAltitude(altitude)
    altitude = 3048 / 10000 * altitude
    altitude = var_cap(altitude, 0, 9999)
    altitude = var_format(altitude, 0)
    vario.navboxAltitude.setValue(altitude)
end

-- Writes the TAS in the 4th navbox
-- @param tas : the tas in knots to be diplayed in km/h
function displayAirspeed(tas)
    tas = tas * 1852 / 1000 --converting to km/h
    tas = var_cap(tas, 0, 9999)
    tas = string.format("%.0f", tas)
    vario.navboxTAS.setValue(tas)
end

-- Subscriptions
fs2020_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", "AMBIENT WIND VELOCITY", "Knots", "HEADING INDICATOR", "Radians", displayWind)
fs2020_variable_subscribe("L:NETTO", "FLOAT", displayNetto)
fs2020_variable_subscribe("L:TOTAL ENERGY", "FLOAT", dislayVario)
fs2020_variable_subscribe("PLANE ALTITUDE", "Feet", displayAltitude)
fs2020_variable_subscribe("AIRSPEED TRUE", "Knots", displayAirspeed)
