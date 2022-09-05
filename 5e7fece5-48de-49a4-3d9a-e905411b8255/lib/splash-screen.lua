-- Creates and displays a SplashScreen
-- @returns : the SplashScreen object
SplashScreen = {}
SplashScreen.new = function()
    local self = {}
    local backgroundOffCover = nil
    local backgroundOffCoverLogo = nil
    local splashScreenText = nil
    local splashScreenText2 = nil

    -- Shows a splash screen with the app version
    function self.startup()
        visible(backgroundOffCoverLogo, true)
        visible(splashScreenText, true)
        visible(splashScreenText2, true)
        timer_start(3000, function()
            visible(backgroundOffCoverLogo, false)
            visible(backgroundOffCover, false)
            visible(splashScreenText, false)
            visible(splashScreenText2, false)
        end)
    end
    -- Displays the background cover
    function self.stop()
        visible(backgroundOffCoverLogo, false)
        visible(backgroundOffCover, true)
        visible(splashScreenText, false)
        visible(splashScreenText2, false)
    end

    -- Initialized by displaying the background cover
    function init()
        backgroundOffCover = img_add_fullscreen("ls100_bg_off_cover.png")
        backgroundOffCoverLogo = img_add_fullscreen("ls100_lxnav_logo.png")
        local splashTxt = "APP version : " .. G.APP_VERSION
        splashScreenText = txt_add(splashTxt, "font:" .. G.FONT .. ";color:" .. G.COLOR_SECONDARY .. ";size:20;halign:center;", 90, 240, 256, 20)
        visible(splashScreenText, false)
        splashScreenText2 = txt_add("Initializing...", "font:" .. G.FONT .. ";color:" .. G.COLOR_SECONDARY .. ";size:15;halign:center;", 90, 270, 256, 15)
        visible(splashScreenText2, false)
        visible(backgroundOffCoverLogo, false)
    end

    init()

    return self
end