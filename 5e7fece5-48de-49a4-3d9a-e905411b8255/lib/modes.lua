-- Handles the pages of the waypoint mode
-- @returns : the WayPointMode object
WayPointMode = {}
WayPointMode.new = function()
    local self = {}
    local pages = { NumericsPage }
    self.navigator = Navigator.new(pages)

    return self
end