-- Displays and rotate the red diamond
-- @param value : the value for the red diamond to display
-- @returns : the RedDiamond object
RedDiamond = {}
RedDiamond.new = function(value)
    local self = {}
    local imgRedDiamond = img_add("ls100_red_diamond.png", 0, 0, 512, 512)

    -- Rotates the RedDiamond according to the value provided
    -- @param value : the value to display
    function self.setValue(value)
        value = var_cap(240 / 10 * value, -120, 120)
        rotate(imgRedDiamond, value)
    end

    return self
end