-- Computes the metric average withing the provided history
-- @param metricValue : the latest metric value
-- @param historyTable : the metric history table reference
-- @param period : the period on which the average is computed
-- @returns : the computed average
function computeAvgMetric(metricValue, historyTable, period)
    local sum = 0
    local arraySize = 0
    local tuple = { metricValue, os.time() }
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
        end
    end
    return sum / arraySize
end

-- Prepends the "+" sign the the value provided if it's positive
-- @param numberValue : the value to be prepended
-- @returns : the "+" prepended number
function prependPlus(numberValue)
    local op = ""
    if numberValue > 0 then
        op = "+"
    end
    return op .. numberValue
end