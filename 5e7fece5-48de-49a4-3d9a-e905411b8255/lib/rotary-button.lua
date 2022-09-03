-- Displays a a rotary button
-- @param position : 'top' or 'bottom', triggers a exception otherwise
-- @param onRotation : Callback handling the dial rotation.
-- @param onPress : Callback handling the button pressure.
-- @returns : the RotaryButton object
RotaryButton = {}
RotaryButton.new = function(position, onPress, onRotation)
    local self = {}
    local x = 412
    local y = 0

    if (not onPress) then
        onPress = function()
            print('This method should be implemented')
        end
    end

    if (not onRotation) then
        onRotation = function()
            print('This method should be implemented')
        end
    end

    if (position == "bottom") then
        y = 412
    elseif (position ~= "top") then
        error("The rotary button position must be 'top' or 'bottom'")
    end

    dial_add("ls100_rotary_button.png", x, y, 100, 100, onRotation)
    button_add("ls100_rotary_button_inner.png", "ls100_rotary_button_inner_pressed.png", x + 15, y + 15, 70, 70, onPress)
    return self
end