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