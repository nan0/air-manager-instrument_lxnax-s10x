-- Displays the maccready needle
-- @param value : the value in m/s for the MacCreadyNeedle to display
-- @returns : the MacCreadyNeedle object
MacCreadyNeedle = {}
MacCreadyNeedle.new = function()
    local self = {}
    local imgMacCreadyNeedle = img_add("ls100_vario_maccready-needle.png", 0, 0, 512, 512)

    -- Rotates the MacCreadyNeedle according to the value provided
    -- @param value : the value to display
    function self.setValue(value)
        if (value ~= 0) then
            value = var_cap(240 / 10 * value, -120, 120)
        end
        rotate(imgMacCreadyNeedle, value)
    end

    return self
end