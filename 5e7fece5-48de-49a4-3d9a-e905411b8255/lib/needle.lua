-- Displays and rotate the vario needle
-- @param value : the value for the needle to display
-- @returns : the Needle object
Needle = {}
Needle.new = function()
    local self = {}
    local imgVarioNeedle = img_add("ls100_vario_needle.png", 0, 0, 512, 512)

    -- Rotates the needle according to the value provided
    -- @param value : the value to display
    function self.setValue(value)
        value = var_cap(240 / 10 * value, -120, 120)
        rotate(imgVarioNeedle, value)
    end

    return self
end