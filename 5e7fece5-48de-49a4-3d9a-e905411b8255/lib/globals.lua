-- A share dobject that stores the global properties and methods
-- @param period : the history period
Globals = {}
Globals.new = function()
    local self = {}

    -- Global constants
    self.CONSTANTS = {
        APP_VERSION = "1.2.0",
        FONT = "roboto_regular.ttf",
        COLOR_PRIMARY = "white",
        COLOR_SECONDARY = "#c2c4c2",
        COLOR_INVERTED = "black",
        TEXT_SIZE = 26,
    }

    -- Instrument settings
    self. S_AVG_VARIO_TIME = 20
    self. S_AVG_NETTO_TIME = 10

    -- Aircraft settings
    self. S_TOTAL_WEIGHT = nil
    self. S_WING_AREA = 11.36 -- 11.36m² for the 18m version
    self.S_DEFAULT_WING_LOAD = 40.6 -- The wing load used by default by the plugin. The csv polar data are computed on value

    -- Prod
    self.S_INIT_TIMEOUT = 3000
    self.S_MASTER_ON = false

    --Dev (To be commented)
--[[    self.S_INIT_TIMEOUT = 0
    self.S_MASTER_ON = true
    self.S_TOTAL_WEIGHT = 450]]

    self.polar = nil

    -- Methods
    function setWeight(weight)
        if not weight then
            return
        end
        weight = poundsToKg(weight)
        S_TOTAL_WEIGHT = var_round(weight)
    end

    -- Initializations
    function init()
        self.polar = Polar.new(self)
        fs2020_variable_subscribe("TOTAL WEIGHT", "Pounds", setWeight)
        fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool", function(on)
            self.S_MASTER_ON = on
        end)
    end

    init()

    return self
end


