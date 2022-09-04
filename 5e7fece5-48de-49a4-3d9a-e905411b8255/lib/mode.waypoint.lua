-- Handles the pages of the waypoint mode
-- @returns : the WayPointMode object
WayPointMode = {}
WayPointMode.new = function()
    local self = Mode.new({ NumericsPage })
    return self
end
