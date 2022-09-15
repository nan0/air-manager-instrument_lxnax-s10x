-- The page interface
-- @param G : the globals object
-- @returns : the Page interface
Page = {}
Page.new = function(G)
    local self = Navigable.new(G)

    -- Toggles the item visibility on or off
    -- @param on : true if has to be displayed, false otherwise
    function self.toggle(on)
    end

    return self
end