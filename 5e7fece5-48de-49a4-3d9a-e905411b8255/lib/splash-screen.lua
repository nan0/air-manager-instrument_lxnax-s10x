-- Creates and displays a SplashScreen
-- @param initCallBack : Function to be overridden by the parent. Called during startup
-- @returns : the SplashScreen object
SplashScreen = {}
SplashScreen.new = function(initCallBack)
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

        timer_start(G.S_INIT_TIMEOUT, function()
            visible(backgroundOffCoverLogo, false)
            visible(backgroundOffCover, false)
            if initCallBack then
                initCallBack()
            end
            splashScreenText.toggle(false)
            splashScreenText2.toggle(false)
        end)
    end

    function self.initOperations()
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
        splashScreenText.setValue("APP version : " .. G.CONSTANTS.APP_VERSION)
        splashScreenText2 = Infobox.new(150, 270)
        splashScreenText2.setValue("Initializing...")

        splashScreenText.toggle(false)
        splashScreenText2.toggle(false)
        visible(backgroundOffCoverLogo, false)
    end

    init()

    return self
end