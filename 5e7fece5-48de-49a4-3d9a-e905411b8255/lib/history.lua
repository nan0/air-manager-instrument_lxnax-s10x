-- Stores a history of values
-- @param period : the history period
History = {}
History.new = function(period)
    local self = {}
    local historyTable = {}
    local period = period
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

    -- Adds a value to the history and computes it
    -- @param elem : the history element to add
    -- @returns : the refreshed history object
    function self.addAndCompute(elem)
        local sum = 0
        local res = {}

        local arraySize = 0
        local tuple = { elem, os.time() }
        table.insert(historyTable, tuple)

        for index, valueTuple in pairs(historyTable) do
            local now = os.time()
            local value = valueTuple[1]
            local value_time = valueTuple[2]
            if value_time < now - period then
                table.remove(historyTable, index)
            else
                arraySize = arraySize + 1
                sum = sum + value

                if value > max then
                    max = value
                end
                if value < min then
                    min = value
                end
            end
        end

        avg = sum / arraySize
        return self
    end

    return self
end