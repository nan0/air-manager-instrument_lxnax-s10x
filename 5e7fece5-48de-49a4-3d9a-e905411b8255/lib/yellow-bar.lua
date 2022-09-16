-- Displays and rotate the yellow bar
-- @param min : the min value for the YellowBar to display
-- @param max : the max value for the YellowBar to display
-- @returns : the YellowBar object
YellowBar = {}
YellowBar.new = function()
    local self = {}
    local yellowBar = img_add("ls100_yellow_bar.png", 0, 0, 512, 512)

    local topCover = img_add("ls100_yellow_bar_half_cover.png", 0, 0, 512, 512)
    viewport_rect(topCover, 0, 0, 512, 256)
    local topCover2 = img_add("ls100_yellow_bar_half_cover.png", 0, 0, 512, 512)
    viewport_rect(topCover2, 0, 0, 512, 256)

    local bottomCover = img_add("ls100_yellow_bar_half_cover.png", 0, 0, 512, 512)
    rotate(bottomCover, 180)
    viewport_rect(bottomCover, 0, 256, 512, 256)
    local bottomCover2 = img_add("ls100_yellow_bar_half_cover.png", 0, 0, 512, 512)
    rotate(bottomCover2, 180)
    viewport_rect(bottomCover2, 0, 256, 512, 256)

    -- Rotates the YellowBar according to the value provided
    -- @param min : the min value to display
    -- @param max : the max value to display
    function self.setValue(min, max)
        local minAngle = var_cap(240 / 10 * min, -140, 140)
        local maxAngle = var_cap(240 / 10 * max, -140, 140)

        rotate(bottomCover, 180 + minAngle, 'LOG', 0.1)
        rotate(topCover, maxAngle, 'LOG', 0.1)

        -- Adds a second cover if the maximum is negative or if the minimum is positive
        if max <= 0 or min >= 0 then
            visible(topCover2, true)
            visible(bottomCover2, true)
            if max <= 0 then
                rotate(bottomCover2, 0 + maxAngle, 'LOG', 0.1)
            end

            if min >= 0 then
                rotate(topCover2, 180 + minAngle, 'LOG', 0.1)
            end
        else
            visible(topCover2, false)
            visible(bottomCover2, false)
        end
    end

    return self
end