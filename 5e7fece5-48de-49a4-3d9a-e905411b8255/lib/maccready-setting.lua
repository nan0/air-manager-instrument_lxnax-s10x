-- Displays the maccready MacCreadySetting
-- @param value : the value for the MacCreadySetting to display
-- @returns : the MacCreadySetting object
MacCreadySetting = {}
MacCreadySetting.new = function()
    local self = {}
    local imgMacCreadySetting = img_add("ls100_vario_maccready-needle.png", 0, 0, 512, 512)

    -- Rotates the MacCreadySetting according to the value provided
    -- @param value : the value to display
    function self.setValue(value)
        value = var_cap(240 / 10 * value, -120, 120)
        rotate(imgMacCreadySetting, value)
    end

    return self
end