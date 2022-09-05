-- Displays the speed to fly arrows
-- @returns : the SpeedToFlyIndicator object
SpeedToFlyIndicator = {}
SpeedToFlyIndicator.new = function()
    local self = {}
    local x = 340
    local width = 30
    local height = width * 2 / 3
    local imgDiamond = img_add("ls100_spf_diamond.png", x, 256 - height / 2, width, height)
    local arrows = {}
    local switchedOn = true

    -- Displays in the arrow indicator the SPF difference with the current speed
    -- @param diff : the difference between the actrual speed and the spf, in km/h. Eg : +26 to fly 26km/h faster, -52 to fly 52 km/h slower
    function self.displayDiff(diff)
        local nbArrows = diff / 10
        nbArrows = var_round(nbArrows)
        nbArrows = var_cap(nbArrows, -10, 10)

        local startIdx = 10
        local endIdx = 10
        if nbArrows < 0 then
            startIdx = nbArrows + 10
        elseif nbArrows > 0 then
            endIdx = nbArrows + 10
        end

        for i = 1, 20 do
            local isVisible = i > startIdx and i <= endIdx
            visible(arrows[i], isVisible)
        end
    end

    -- Toggles on or of the indicator
    function self.toggle(on)
        switchedOn = on
        visible(imgDiamond, switchedOn)
        for i = 1, 20 do
            visible(arrows[i], false)
        end
    end

    -- Inits the spf arrows
    function init()
        local bottomPos = 366
        for i = -10, 10 do
            if i ~= 0 then
                table.insert(arrows, img_add("ls100_spf_arrow.png", x, bottomPos, width, height))
                if i < 0 then
                    rotate(arrows[#arrows], 180)
                end
            end
            bottomPos = (bottomPos - height / 2) - 2
            visible(arrows[#arrows], false)
        end
    end

    -- Inits
    init()

    return self
end