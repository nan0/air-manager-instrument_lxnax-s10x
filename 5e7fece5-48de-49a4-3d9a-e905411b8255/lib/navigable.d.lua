-- "Interface" to be extend in order to be able to use the navigator with
-- @returns the Navigable interface like
Navigable = {}
Navigable.new = function()

    local self = {}

    -- Handles the top button pressure
    function self.onTopButtonPressed()
    end

    -- Handles the middle button pressure
    function self.onMiddleButtonPressed(direction)
    end

    -- Handles the bottom button pressure
    function self.onBottomButtonPressed()
    end

    -- Handles the top knob pressure
    function self.onTopKnobPressed()
    end

    -- Handles the top knob rotation
    -- @param direction: 1 if rotates clockwise, -1 otherwise
    function self.onTopKnobRotated(direction)
    end

    -- Handles the bottom knob pressure
    function self.onBottomKnobPressed()
    end

    -- Handles the bottom knob rotation
    -- @param direction: 1 if rotates clockwise, -1 otherwise
    function self.onBottomKnobRotated(direction)
    end

    return self
end