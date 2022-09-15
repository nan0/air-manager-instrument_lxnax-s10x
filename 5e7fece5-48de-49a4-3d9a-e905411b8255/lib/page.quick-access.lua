-- The Quick Access page
-- @param G : the globals object
-- @returns : the QuickAccessPage object
QuickAccessPage = {}
QuickAccessPage.new = function(G)
    local self = Page.new(G)

    mcCreadyBox = Centralbox.new("MC CREADY", G.polar.getMcCready(), "m/s")
    mcCreadyNeedle = MacCreadyNeedle.new()
    infoBox = Infobox.new(170, 300)
    infoBox2 = Infobox.new(170, 320)

    -- Builds the text to be set in the infobox
    -- @returns : the text as a string
    function buildInfoTxt()
        local wingArea = nil
        if not G.S_TOTAL_WEIGHT or G.S_TOTAL_WEIGHT == 0 then
            wingArea = "0"
        else
            wingArea = G.S_TOTAL_WEIGHT / 11.36
            wingArea = var_round(wingArea)
        end

        return string.format("Load : %dkg/m²", wingArea)
    end

    -- Sets the mccready settings in the global variable, the needle and the center box
    function self.changeMcCready(value)
        G.polar.setMcCready(value)
        mcCreadyBox.setValue(prependPlus(value))
        mcCreadyNeedle.setValue(value)
        infoBox.setValue(buildInfoTxt())
        infoBox2.setValue("")
    end

    -- @inheritDoc
    function self.toggle(on)
        visible(mcCreadyBox.getNode(), on)
        infoBox.toggle(on)
        infoBox2.toggle(on)
        if on then
            self.changeMcCready(G.polar.getMcCready())
        end
    end

    -- @inheritDoc
    self.onBottomKnobRotated = function(direction)
        local increment = direction / 10 * 5
        local newValue = G.polar.getMcCready() + increment
        newValue = var_round(newValue, 1)
        newValue = var_cap(newValue, 0.0, 5.0)
        self.changeMcCready(newValue)
    end

    -- Inits the page
    function init()
        self.toggle(false)
    end

    init()

    return self
end