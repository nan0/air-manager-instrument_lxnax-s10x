-- The vario main object
-- @returns : the Vario object
Vario = {}
Vario.new = function()
    local self = {}
    local modes = { WayPointMode }
    local varioHistory = History.new(S_AVG_VARIO_TIME)
    local nettoHistory = History.new(S_AVG_NETTO_TIME)

    -- Callback handling the top knob pressure
    function onTopKnobPressed()

    end

    -- Callback handling the top knob rotation
    -- @param direction : 1 when the dial is being turned clockwise, -1 otherwise
    function onTopKnobRotated(direction)

    end

    -- Callback handling the bottom knob pressure
    function onBottomKnobPressed()

    end

    -- Callback handling the bottom knob rotation
    -- @param direction : 1 when the dial is being turned clockwise, -1 otherwise
    function onBottomKnobRotated()

    end

    -- Sets the orange needle to the total energy vario value, and displays the min/max vario in the yellow line
    -- @param totalEnergy : the latest total energy vario value
    function updateVario(totalEnergy)
        self.needle.setValue(totalEnergy)
        varioHistory.addAndCompute(totalEnergy)
        self.yellowBar.setValue(varioHistory.getMin(), varioHistory.getMax())
    end

    -- Sets the red diamond to the avg. netto
    -- @param netto : the latest netto value
    function updateNetto(netto)
        local avgNetto = 0
        avgNetto = nettoHistory.addAndCompute(netto).getAvg()
        self.redDiamond.setValue(avgNetto)
    end

    -- Inits the vario
    function init()
        -- Needles and background init
        self.yellowBar = YellowBar.new()
        img_add_fullscreen("ls100_bg.png")
        txt_add("m/s", "font:" .. G.FONT .. "; color:" .. G.COLOR_INVERTED .. "; size:23; halign: right;", 310, 440, 30, 23)
        self.macCreadySetting = MacCreadySetting.new()
        self.redDiamond = RedDiamond.new()
        self.needle = Needle.new()
        self.knobTop = RotaryButton.new("top", onTopKnobPressed, onTopKnobRotated)
        self.knobBottom = RotaryButton.new("bottom", onBottomKnobPressed, onBottomKnobRotated)

        -- Navigator init
        self.navigator = Navigator.new(modes)

        -- Subscriptions
        fs2020_variable_subscribe("L:TOTAL ENERGY", "FLOAT", updateVario)
        fs2020_variable_subscribe("L:NETTO", "FLOAT", updateNetto)
    end

    init()

    return self
end
