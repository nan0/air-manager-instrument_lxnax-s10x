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
-- @param nb : the vpound nb to convert
-- @returns : the value in kg
function poundsToKg(nb)
    return 45359237 / 100000000 * nb
end
