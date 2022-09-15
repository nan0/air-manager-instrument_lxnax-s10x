-- Provides tools to navigate between generic items
-- @param navigationItems : the fixed item list to navigate into
-- @param G : the globals object
Navigator = {}
Navigator.new = function(navigationItems, G)
    if (not navigationItems or #navigationItems == 0) then
        G.error.raise("The navigator must be instanced with at least one item")
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
        self.currentItem = navigationItems[currentIndex].new(G)
    end

    -- Displays the previous navigator item, or the first item if not any previous one
    function self.prevItem()
        if (#navigationItems >= currentIndex - 1) then
            currentIndex = currentIndex - 1
        else
            currentIndex = 1
        end
        self.currentItem = navigationItems[currentIndex].new(G)
    end

    -- Init the navigator by displaying the 1st item provided
    function init()
        self.nextItem()
    end

    init()

    return self
end