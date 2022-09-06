-- The Quick Access page
-- @returns : the QuickAccessPage object
QuickAccessPage = {}
QuickAccessPage.new = function()
    local self = Page.new()

    mcCreadyBox = Centralbox.new("MC CREADY", S_MACCREADY, "m/s")
    mcCreadyNeedle = MacCreadyNeedle.new()
    infoBox = Infobox.new(150, 300)

    -- Builds the text to be set in the infobox
    -- @returns : the text as a string
    function buildInfoTxt()
        return "Total weight : " .. S_TOTAL_WEIGHT .. "kg"
    end

    -- Sets the mccready settings in the global variable, the needle and the center box
    function self.setMcCready(value)
        S_MACCREADY = var_cap(value, -5, 5)
        S_MACCREADY = prependPlus(S_MACCREADY)
        mcCreadyBox.setValue(S_MACCREADY)
        mcCreadyNeedle.setValue(S_MACCREADY)
        infoBox.setValue(buildInfoTxt())
    end

    -- @inheritDoc
    function self.toggle(on)
        visible(mcCreadyBox.getNode(), on)
        infoBox.setValue(buildInfoTxt())
        infoBox.toggle(on)
    end

    -- @inheritDoc
    self.onBottomKnobRotated = function(direction)
        local newValue = S_MACCREADY + (direction / 10)
        self.setMcCready(newValue)
        infoBox.setValue(buildInfoTxt())
    end

    -- Inits the page
    function init()
        self.toggle(false)
    end

    init()

    return self
end