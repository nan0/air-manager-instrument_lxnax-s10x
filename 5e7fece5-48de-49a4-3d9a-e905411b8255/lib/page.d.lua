-- The page interface
-- @returns : the Page interface
Page = {}
Page.new = function()
    local self = Navigable.new()

    -- Toggles the item visibility on or off
    -- @param on : true if has to be displayed, false otherwise
    function self.toggle(on)
    end

    return self
end