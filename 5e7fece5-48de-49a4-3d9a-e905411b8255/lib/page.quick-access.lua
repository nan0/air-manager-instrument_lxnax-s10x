-- The Quick Access page
-- @returns : the QuickAccessPage object
QuickAccessPage = {}
QuickAccessPage.new = function()
    local self = Page.new()

    mcCreadyBox = Centralbox.new("MC CREADY", S_MACCREADY, "m/s")
    mcCreadyNeedle = MacCreadyNeedle.new()
    infoBox = Infobox.new(170, 300)
    infoBox2 = Infobox.new(170, 320) -- TODO: Remove this

    -- Builds the text to be set in the infobox
    -- @returns : the text as a string
    function buildInfoTxt()
        local wingArea = S_TOTAL_WEIGHT / 11.36
        wingArea = var_round(wingArea)
        return string.format("Load : %dkg/m²", wingArea)
    end

    -- Sets the mccready settings in the global variable, the needle and the center box
    function self.setMcCready(value)
        S_MACCREADY = var_cap(value, -5, 5)
        mcCreadyBox.setValue(prependPlus(S_MACCREADY))
        mcCreadyNeedle.setValue(S_MACCREADY)
        infoBox.setValue(buildInfoTxt())
        infoBox2.setValue("Total weight : " .. S_TOTAL_WEIGHT .. "kg")  -- TODO: Remove this
    end

    -- @inheritDoc
    function self.toggle(on)
        visible(mcCreadyBox.getNode(), on)
        infoBox.toggle(on)
        infoBox2.toggle(on)  -- TODO: Remove this
        if on then
            self.setMcCready(S_MACCREADY)
        end
    end

    -- @inheritDoc
    self.onBottomKnobRotated = function(direction)
        local newValue = S_MACCREADY + (direction / 10)
        self.setMcCready(newValue)
    end

    -- Inits the page
    function init()
        self.toggle(false)
    end

    init()

    return self
end