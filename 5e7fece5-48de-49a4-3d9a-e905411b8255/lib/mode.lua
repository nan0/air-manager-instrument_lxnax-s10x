-- The generic Mode object
-- @param pages: the page list to be navigated
-- @returns the Mode object
Mode = {}
Mode.new = function(pages, G)
    local self = Navigable.new(G)
    local quickAccessPageOpened = false
    local quickAccessPage = QuickAccessPage.new(G)

    self.previousPage = nil
    self.pageNavigator = Navigator.new(pages, G)

    self.onTopKnobPressed = function()
        if (not G.S_MASTER_ON) then
            return
        end
        self.pageNavigator.currentItem.onTopKnobPressed(direction)
    end

    self.onTopKnobRotated = function(direction)
        if (not G.S_MASTER_ON) then
            return
        end
        self.pageNavigator.currentItem.onTopKnobRotated(direction)
    end

    self.onBottomKnobPressed = function()
        if (not G.S_MASTER_ON) then
            return
        end
        if (not quickAccessPageOpened) then
            -- Shows the quick Acces Page
            self.pageNavigator.currentItem.toggle(false)
            self.previousPage = self.pageNavigator.currentItem
            self.pageNavigator.currentItem = quickAccessPage
            self.pageNavigator.currentItem.toggle(true)
            quickAccessPageOpened = true
        else
            -- Hide the quick Acces Page
            self.pageNavigator.currentItem.toggle(false)
            self.pageNavigator.currentItem = self.previousPage
            self.pageNavigator.currentItem.toggle(true)
            self.previousPage = nil
            quickAccessPageOpened = false
        end
    end

    self.onBottomKnobRotated = function(direction)
        if (not G.S_MASTER_ON) then
            return
        end
        self.pageNavigator.currentItem.onBottomKnobRotated(direction)
    end

    return self
end