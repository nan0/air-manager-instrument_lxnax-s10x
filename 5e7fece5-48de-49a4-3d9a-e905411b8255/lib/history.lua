-- Stores a history of values
-- @param period : the history period
History = {}
History.new = function(period)
    local self = {}
    local historyTable = {}
    local min = 0
    local max = 0
    local avg = 0

    -- @returns the minimum value in the history
    function self.getMin()
        return min
    end

    -- @returns the maximum value in the history
    function self.getMax()
        return max
    end

    -- @returns the average value of the history
    function self.getAvg()
        return avg
    end

    local function clearExpiredValues()
        -- Removing expired values
        local now = os.time()
        local i = 1
        while historyTable[i] and historyTable[i][2] < now - period do
            table.remove(historyTable, i)
            i = i + 1
        end
    end
    -- Adds a value to the history and computes it
    -- @param elem : the history element to add
    -- @returns : the refreshed history object
    function self.addAndCompute(elem)
        clearExpiredValues()
        local res = {}
        local arraySize = 0
        local sum = 0
        local tuple = { elem, os.time() }
        table.insert(historyTable, tuple)
        min = nil
        max = nil
        for index, valueTuple in pairs(historyTable) do
            local value = valueTuple[1]
            arraySize = arraySize + 1
            sum = sum + value

            if not min or value < min then
                min = value
            end

            if not max or value > max then
                max = value
            end
        end
        avg = sum / arraySize
        return self
    end

    return self
end