-- Handles the pages of the waypoint mode
-- @param G : the globals object
-- @returns : the WayPointMode object
WayPointMode = {}
WayPointMode.new = function(G)
    local self = Mode.new({ NumericsPage }, G)
    return self
end
