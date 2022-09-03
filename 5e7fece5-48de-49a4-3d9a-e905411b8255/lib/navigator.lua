-- Displays and rotate the yellow bar
-- @param min : the min value for the YellowBar to display
-- @param max : the max value for the YellowBar to display
-- @returns : the YellowBar object
Navigator = {}
Navigator.new = function(navigationItems)
    if (not navigationItems or #navigationItems == 0) then
        error("The navigator must be instanced with at least one item")
    end

    local self = {}
    local currentIndex = 0
    self.currentItem = nil

    -- Displays the next navigator item, or the first item if not any next one
    function self.nextItem()
        if (#navigationItems <= (currentIndex + 1)) then
            currentIndex = currentIndex + 1
        else
            currentIndex = 1
        end
        print(currentIndex)
        self.currentItem = navigationItems[currentIndex].new()
    end

    -- Displays the previous navigator item, or the first item if not any previous one
    function self.prevItem()
        if (#navigationItems >= currentIndex - 1) then
            currentIndex = currentIndex - 1
        else
            currentIndex = 1
        end
        self.currentItem = navigationItems[currentIndex].new()
    end

    -- Init the navigator by displaying the 1st item provided
    function init()
        self.nextItem()
    end

    init()

    return self
end