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
        splashScreenText.toggle(true)
        splashScreenText2.toggle(true)
        timer_start(S_INIT_TIMEOUT, function()
            visible(backgroundOffCoverLogo, false)
            visible(backgroundOffCover, false)
            splashScreenText.toggle(false)
            splashScreenText2.toggle(false)
        end)
    end
    -- Displays the background cover
    function self.stop()
        visible(backgroundOffCoverLogo, false)
        visible(backgroundOffCover, true)
        splashScreenText.toggle(false)
        splashScreenText2.toggle(false)
    end

    -- Initialized by displaying the background cover
    function init()
        backgroundOffCover = img_add_fullscreen("ls100_bg_off_cover.png")
        backgroundOffCoverLogo = img_add_fullscreen("ls100_lxnav_logo.png")

        splashScreenText = Infobox.new(150, 240)
        splashScreenText.setValue("APP version : " .. G.APP_VERSION)
        splashScreenText2 = Infobox.new(150, 270)
        splashScreenText2.setValue("Initializing...")

        splashScreenText.toggle(false)
        splashScreenText2.toggle(false)
        visible(backgroundOffCoverLogo, false)
    end

    init()

    return self
end