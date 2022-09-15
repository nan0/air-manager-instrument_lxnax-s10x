-- Object containing polar computing tools
-- @param G: the globals object
-- @returns : the Polar object
Polar = {}
Polar.new = function(G)
    if not G.S_TOTAL_WEIGHT then
        error('The total weight of the glider must be set in order to compute its polar data')
    end

    local self = {}
    local polarData = nil
    local mcCreadySetting = 0.0

    -- Returns the closest recorded vspeed in the csv data
    -- @params vspeed : the current vspeed pf the glider
    -- @returns : the closest vspeed recorded as string
    function getClosestData(vspeed)
        local closestDiff = nil
        local closestVspeed = nil
        for k, v in pairs(polarData[1]) do
            if k ~= "mcCready" then
                k = tonumber(k)
                local diff = math.abs(vspeed - k)
                if not closestDiff or diff < closestDiff then
                    closestVspeed = k
                    closestDiff = diff
                end
            end
        end
        return tostring(closestVspeed)
    end

    -- Loads the csv polar data from the file "resources/default_polar_data.csv"
    function loadData()
        local data = static_data_load("default_polar_data.csv")
        if (data == nil) then
            error("Error while reading the polar data. The data must be a valid json set in /ressources/default_polar_data.csv")
        end
        polarData = data
    end

    -- Computes the speed to fly from the polarData, based on the current wing load and MacCready setting
    -- @param wingLoad : the current wing load
    -- @param vspeed : the current vertical speed of the plane in m/s
    -- @param mcCready : the current maccready setting in m/s
    -- @param polarData : csv data of a specific wing load, as defined in default_polar_data.csv
    -- @returns the speed to fly in km/h
    function self.getSpeedToFly(vspeed)
        for k, v in pairs(polarData) do
            local mcCreadyCell = tonumber(v["mcCready"])
            if mcCreadyCell == mcCreadySetting then
                local vspeed = getClosestData(vspeed - mcCreadySetting)
                local hSpeed = v[tostring(vspeed)]
                -- Adjust the hspeed according to the wing loading
                -- Computes the difference between the current wing load and the lightest values that have been loaded
                local defaultWeight = G.S_WING_AREA * G.S_DEFAULT_WING_LOAD
                local adjustment = (G.S_TOTAL_WEIGHT / defaultWeight - 1) / 2
                local spf = hSpeed * (1 + adjustment)
                return var_round(spf)
            end
        end
        error('Speed to fly not found in the data provided')
    end

    --Sets the mcCready sert
    function self.setMcCready(mcCready)
        mcCreadySetting = mcCready
    end

    --Returns the current mcCready setting
    function self.getMcCready()
        return mcCreadySetting
    end

    -- initializations
    function init()
        loadData()
    end

    init()

    return self
end