-- The Quick Access page
-- @returns : the QuickAccessPage object
QuickAccessPage = {}
QuickAccessPage.new = function()
    local self = Page.new()

    mcCreadyBox = Centralbox.new('MC CREADY', S_MACCREADY, 'm/s')
    mcCreadyNeedle = MacCreadyNeedle.new()

    -- @inheritDoc
    function self.toggle(enabled)
        visible(mcCreadyBox.getNode(), enabled)
    end

    self.onBottomKnobRotated = function(direction)
        S_MACCREADY = S_MACCREADY + (direction / 10)
        S_MACCREADY = var_cap(S_MACCREADY, -5, 5)
        S_MACCREADY = prependPlus(S_MACCREADY)
        mcCreadyBox.setValue(S_MACCREADY)
        mcCreadyNeedle.setValue(S_MACCREADY)
    end

    -- Inits the page
    function init()
        self.toggle(false)
    end

    init()

    return self
end