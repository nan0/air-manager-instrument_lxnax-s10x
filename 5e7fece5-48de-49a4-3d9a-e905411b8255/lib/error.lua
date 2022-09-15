-- Handles a error that occurs and displays it in the screen
-- @returns : the Error object
Error = {}
Error.new = function()
    local self = {}

    -- Displays a error
    function self.raise(msg)
        img_add_fullscreen("ls100_error.png")
        RotaryButton.new("top")
        RotaryButton.new("bottom")
        txt_add(msg, "font:roboto_regular.ttf;color:yellow;size:12;halign:center", 25, 300, 370, 25)
        error(msg)
    end

    return self
end