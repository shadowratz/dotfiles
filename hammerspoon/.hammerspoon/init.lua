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
        -- a = "Antigravity",
        a = "Zed",
        b = "Notion",
        -- c handled below as Chrome window cycler
        -- c = "Google Chrome Dev",
        -- c = "Arc",
        -- c = "Firefox",
        -- c = "Firefox Developer Edition",
        d = "OrbStack",
        -- g = "Sourcetree",
        -- k handled below as Teams/Slack toggle
        -- m = "Notion",
        -- o = "Obsidian",
        -- m = "Emacs",
        -- o = "1Password",
        -- p = "Postman",
        q = "DBeaver",
        s = "Safari",
        w = "WhatsApp",
        -- x = "Visual Studio Code",
        -- z = "Zed",
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
            -- App is hidden; show and focus it
            hs.application.launchOrFocus(appName)
        elseif app:isFrontmost() then
            -- App is visible and currently focused; hide it
            app:hide()
        else
            -- App is visible but not focused; bring it to focus
            hs.application.launchOrFocus(appName)
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

-- Toggle between Microsoft Teams and Slack on repeated presses
function toggleTeamsSlack()
    local teams = hs.application.get("Microsoft Teams")
    local slack = hs.application.get("Slack")
    local frontmost = hs.application.frontmostApplication()
    local frontName = frontmost and frontmost:name() or ""

    if frontName == "Microsoft Teams" then
        hs.application.launchOrFocus("Slack")
    elseif frontName == "Slack" then
        hs.application.launchOrFocus("Microsoft Teams")
    else
        -- Neither is focused; prefer Teams if running, else Slack, else launch Teams
        if teams then
            hs.application.launchOrFocus("Microsoft Teams")
        elseif slack then
            hs.application.launchOrFocus("Slack")
        else
            hs.application.launchOrFocus("Microsoft Teams")
        end
    end
end

hs.hotkey.bind(hyper, "k", toggleTeamsSlack)

-- Cycle through ALL Chrome windows across every Space, via AppleScript.
-- Uses stable window IDs sorted numerically so cycle doesn't get stuck on 2 windows.
chromeLastWinId = nil

function cycleChromeWindows()
    local bundleID = "com.google.Chrome"
    local app = hs.application.get(bundleID)
    if not app then
        hs.application.launchOrFocusByBundleID(bundleID)
        return
    end

    local ok, ids = hs.osascript.applescript(
        'tell application "Google Chrome" to get id of every window')
    if not ok or type(ids) ~= "table" or #ids == 0 then
        hs.application.launchOrFocusByBundleID(bundleID)
        return
    end

    table.sort(ids)
    print("[cycleChrome] ids:", table.concat(ids, ","), "last:", tostring(chromeLastWinId))

    local idx = 0
    for i, id in ipairs(ids) do
        if id == chromeLastWinId then idx = i; break end
    end
    local nextId = ids[(idx % #ids) + 1]
    chromeLastWinId = nextId

    local script = string.format([[
        tell application "Google Chrome"
            activate
            set theWin to first window whose id is %d
            set index of theWin to 1
        end tell
    ]], nextId)
    hs.osascript.applescript(script)
end

hs.hotkey.bind(hyper, "c", cycleChromeWindows)

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
