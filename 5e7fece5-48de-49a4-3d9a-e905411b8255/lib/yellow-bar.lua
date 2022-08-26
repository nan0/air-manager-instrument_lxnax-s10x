-- Displays and rotate the yellow bar
-- @param min : the min value for the YellowBar to display
-- @param max : the max value for the YellowBar to display
-- @returns : the YellowBar object
YellowBar = {}
YellowBar.new = function()
    local self = {}
    local imgVarioYellowBar = img_add("ls100_yellow_bar.png", 0, 0, 512, 512)
    local imgVarioYellowCoverTop = img_add("ls100_yellow_bar_half_cover.png", 0, 0, 512, 512)
    local imgVarioYellowCoverBottom = img_add("ls100_yellow_bar_half_cover.png", 0, 0, 512, 512)
    rotate(imgVarioYellowCoverBottom, 180)

    -- Rotates the YellowBar according to the value provided
    -- @param min : the min value to display
    -- @param max : the max value to display
    function self.setValue(min, max)
        local minAngle = var_cap(240 / 10 * min, -140, 140)
        local maxAngle = var_cap(240 / 10 * max, -140, 140)
        rotate(imgVarioYellowCoverBottom, 180 + minAngle, 'LOG', 0.1)
        viewport_rect(imgVarioYellowCoverBottom, 0, 256, 512, 256)
        rotate(imgVarioYellowCoverTop, maxAngle, 'LOG', 0.1)
        viewport_rect(imgVarioYellowCoverTop, 0, 0, 512, 256)
    end

    return self
end