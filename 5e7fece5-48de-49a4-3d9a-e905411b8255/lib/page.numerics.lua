-- The numerical page
-- @returns : the NumericsPage object
NumericsPage = {}
NumericsPage.new = function()
    local self = {}
    local varioHistory = History.new(S_AVG_VARIO_TIME)

    -- Add a Navbox at the requested position
    -- @param position: the navbox position between 1 and 4
    -- @param label: the navbox label
    -- @param value: the navbox initial value
    -- @param unit: the value unit
    function addNavbox(position, label, value, unit)
        if (position < 1 or position > 4) then
            error("The position must be between 1 and 4")
        end

        local y = 30 + position * 75
        return Navbox.new(y, label, value, unit)
    end

    -- Displays the wind direction in a arrow icon and in a textbox
    -- @param windDirection : the wind velocity in degrees
    -- @param windVelocity : the wind velocity in knots to be displayed in m/s
    -- @param planeDirection : the plane direction in radians
    function displayWind(windDirection, windVelocity, planeDirection)
        self.windbox.setWindDirection(windDirection)

        planeDirection = var_round(180 / math.pi * planeDirection, 0)
        local direction = windDirection - planeDirection
        self.windbox.setRelativeDirection(direction)

        windVelocity = windVelocity / 1.94 -- Converting knots to m/s
        windVelocity = var_format(windVelocity, 0)
        self.windbox.setVelocity(windVelocity)
    end

    -- Writes the avg. vario in the 1st navbox
    -- @param vario : the latest total energy vario value
    function dislayVario(totalEnergy)
        avgVario = varioHistory.addAndCompute(totalEnergy).getAvg()
        avgVario = prependPlus(avgVario)
        avgVario = string.format("%.1f", avgVario)
        self.navboxAvgVario.setValue(avgVario)
    end

    -- Writes the current netto in the 2nd navbox
    -- @param netto : the latest netto value
    function displayNetto(netto)
        netto = prependPlus(netto)
        netto = string.format("%.1f", netto)
        self.navboxNetto.setValue(netto)
    end

    -- Writes the altitude in the 3rd navbox
    -- @param altitude : the altitude in ft to be displayed in meters
    function displayAltitude(altitude)
        altitude = 3048 / 10000 * altitude
        altitude = var_cap(altitude, 0, 9999)
        altitude = var_format(altitude, 0)
        self.navboxAltitude.setValue(altitude)
    end

    -- Writes the TAS in the 4th navbox
    -- @param tas : the tas in knots to be diplayed in km/h
    function displayAirspeed(tas)
        tas = tas * 1852 / 1000 --converting to km/h
        tas = var_cap(tas, 0, 9999)
        tas = string.format("%.0f", tas)
        self.navboxTAS.setValue(tas)
    end

    -- Inits the page
    function init()
        print('called')
        self.windbox = Windbox.new()
        self.navboxAvgVario = addNavbox(1, "Avg.vario", 0, "m/s")
        self.navboxNetto = addNavbox(2, "Netto", 0, "m/s")
        self.navboxAltitude = addNavbox(3, "Altitude", 0, "m")
        self.navboxTAS = addNavbox(4, "True airspeed", 0, "km/h")

        -- Subscriptions
        fs2020_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees", "AMBIENT WIND VELOCITY", "Knots", "HEADING INDICATOR", "Radians", displayWind)
        fs2020_variable_subscribe("L:NETTO", "FLOAT", displayNetto)
        fs2020_variable_subscribe("L:TOTAL ENERGY", "FLOAT", dislayVario)
        fs2020_variable_subscribe("PLANE ALTITUDE", "Feet", displayAltitude)
        fs2020_variable_subscribe("AIRSPEED TRUE", "Knots", displayAirspeed)
    end

    init()

    return self
end