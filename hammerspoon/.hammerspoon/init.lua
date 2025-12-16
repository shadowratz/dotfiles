hs.application.enableSpotlightForNameSearches(true)
hyper = { "cmd", "shift", "ctrl" }
hs.hotkey.bind(hyper, "1", hs.reload)

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("MiroWindowsManager", {
    hotkeys = {
        up = { hyper, "up" },
        right = { hyper, "r" },
        down = { hyper, "down" },
        left = { hyper, "l" },
        fullscreen = { hyper, "f" }
    }
})

spoon.SpoonInstall:andUse("AppLauncher", {
    config = { modifiers = hyper },
    hotkeys = {
        -- a = "Zed Preview",
        a = "Visual Studio Code",
        -- a = "Zed",
        -- c = "Google Chrome",
        c = "Google Chrome Dev",
        -- c = "Arc",
        -- c = "Firefox",
        -- c = "Firefox Developer Edition",
        d = "OrbStack",
        -- g = "Sourcetree",
        k = "Cliq",
        m = "Figma",
        -- m = "Obsidian",
        -- m = "Emacs",
        o = "1Password",
        -- p = "Postman",
        q = "DBeaver",
        s = "Safari",
        w = "WhatsApp",
        x = "Firefox",
        z = "Zed",
    }
})


-- Cycle Focused window to multiple screens
function moveToNextScreen()
    local app = hs.window.focusedWindow()
    app:moveToScreen(app:screen():next())
    -- app:maximize()
end

hs.hotkey.bind(hyper, "n", moveToNextScreen)
-- Cycle Focused window to multiple screens - END

-- show / hide the terminal
function toggleTerminal()
    --local appName = "Terminal"
    local appName = "Alacritty"
    -- local appName = "Warp"
    local app = hs.appfinder.appFromName(appName)
    if app == nil then
        hs.application.launchOrFocus(appName)
    else
        if app:isHidden() then
            hs.application.launchOrFocus(appName)
        else
            app:hide() -- hide
        end
    end
end

-- show / hide the notes
function toggleNotes()
    local appName = "Emacs"
    local app = hs.appfinder.appFromName(appName)
    if app == nil then
        hs.application.launchOrFocus(appName)
    else
        if app:isHidden() then
            hs.application.launchOrFocus(appName)
        else
            app:hide() -- hide
        end
    end
end

hs.hotkey.bind({ "cmd" }, "`", toggleTerminal)
hs.hotkey.bind(hyper, "m", toggleNotes)

-- end

caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("😳")
    else
        caffeine:setTitle("💤")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end



hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" }):send()
