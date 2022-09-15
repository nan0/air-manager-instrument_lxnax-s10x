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

-- Converts a amount in pounds to kg
-- @param nb : the pound nb to convert
-- @returns : the value in kg
function poundsToKg(nb)
    return 45359237 / 100000000 * nb
end

-- Converts a amount in knots to km/h
-- @param speed : the speed in knots to convert
-- @returns : the speed in km/h
function knotsToKmh(speed)
    return speed * 1852 / 1000
end

-- Converts a amount in km/h to m/s
-- @param speed : the speed in km/h
-- @returns : the speed in m/s
function kmhToMs(speed)
    return speed / 3.6
end

-- Converts a amount in m/s to km/h
-- @param speed : the speed in m/s
-- @returns : the speed in  km/h
function msToKmh(speed)
    return speed * 3.6
end