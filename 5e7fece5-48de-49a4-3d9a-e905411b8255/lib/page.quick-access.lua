-- The Quick Access page
-- @returns : the QuickAccessPage object
QuickAccessPage = {}
QuickAccessPage.new = function()
    local self = Page.new()

    mcCreadyBox = Centralbox.new('MC CREADY', S_MACCREADY, 'm/s')
    mcCreadyNeedle = MacCreadyNeedle.new()

    -- Sets the mccready settings in the global variable, the needle and the center box
    function self.setMcCready(value)
        S_MACCREADY = var_cap(value, -5, 5)
        S_MACCREADY = prependPlus(S_MACCREADY)
        mcCreadyBox.setValue(S_MACCREADY)
        mcCreadyNeedle.setValue(S_MACCREADY)
    end

    -- @inheritDoc
    function self.toggle(enabled)
        visible(mcCreadyBox.getNode(), enabled)
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