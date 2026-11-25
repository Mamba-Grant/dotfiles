local vars = require("mamba.vars")

local repeating        = { repeating = true }
local locked           = { locked = true }
local locked_repeating = { locked = true, repeating = true }
local release          = { release = true }
local mouse            = { mouse = true }

local function exec(cmd) return hl.dsp.exec_cmd(cmd) end
local function caelestia(name) return hl.dsp.global("caelestia:" .. name) end

------------------
-- Apps / tools --
------------------

hl.bind("SUPER + D",      caelestia("launcher"))
hl.bind("SUPER + T",      exec(vars.terminal))
hl.bind("SUPER + Return", exec(vars.fileManager))
hl.bind("CTRL + SUPER + Slash", exec("pkill anyrun || anyrun"))
hl.bind("SUPER + V",      exec("pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + SHIFT + C", exec("hyprpicker -a"))

local slurp = '$(slurp -d -c eedcf5BB -b 4f425644 -s 00000000)'
hl.bind("SUPER + SHIFT + ALT + S", exec('grim -g "' .. slurp .. '" - | swappy -f -'))
hl.bind("CTRL + SUPER + SHIFT + S", exec('grim -g "' .. slurp .. '" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png"'))

hl.bind("CTRL + SHIFT + ALT + Delete", exec("pkill wlogout || wlogout -p layer-shell"))
hl.bind("CTRL + SHIFT + ALT + SUPER + Delete", exec("systemctl poweroff"))
hl.bind("CTRL + SUPER + H", exec("hyprctl reload"))

-- Test notifications
hl.bind("SUPER + ALT + F12", exec(
    "notify-send 'Test notification' 'Here is a really long message to test truncation and wrapping\\nYou can middle click or flick this notification to dismiss it!' -a 'Shell' -A 'Test1=I got it!' -A 'Test2=Another action'"))
hl.bind("SUPER + ALT + Equal", exec("notify-send 'Urgent notification' 'Ah hell no' -u critical -a 'Hyprland keybind'"))

--------------
-- Caelestia --
--------------

hl.bind("CTRL + ALT + C", caelestia("clearNotifs"), locked)
hl.bind("SUPER + K",      caelestia("showall"), locked)
hl.bind("SUPER + SHIFT + S", caelestia("screenshotFreeze"), locked)
hl.bind("Print", exec("caelestia screenshot"), locked)

hl.bind("CTRL + SUPER + SHIFT + R", exec("qs -c caelestia kill"), release)
hl.bind("CTRL + SUPER + ALT + R",   exec("qs -c caelestia kill; caelestia shell -d"), release)

-- Also available in your locked Caelestia revision, currently unbound:
--   session, sidebar, dashboard, utilities, nexus, lock, unlock, screenshot,
--   screenshotClip, screenshotFreezeClip   (use caelestia("<name>"))

-- Brightness / media / volume
hl.bind("XF86MonBrightnessUp",   caelestia("brightnessUp"),   locked_repeating)
hl.bind("XF86MonBrightnessDown", caelestia("brightnessDown"), locked_repeating)

hl.bind("CTRL + SUPER + Space", caelestia("mediaToggle"), locked_repeating)
hl.bind("XF86AudioPlay",        caelestia("mediaToggle"), locked_repeating)
hl.bind("XF86AudioPause",       caelestia("mediaToggle"), locked_repeating)
hl.bind("CTRL + SUPER + Equal", caelestia("mediaNext"),   locked_repeating)
hl.bind("XF86AudioNext",        caelestia("mediaNext"),   locked_repeating)
hl.bind("CTRL + SUPER + Minus", caelestia("mediaPrev"),   locked_repeating)
hl.bind("XF86AudioPrev",        caelestia("mediaPrev"),   locked_repeating)
hl.bind("XF86AudioStop",        caelestia("mediaStop"),   locked_repeating)

hl.bind("XF86AudioRaiseVolume", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), locked_repeating)
hl.bind("XF86AudioLowerVolume", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), locked_repeating)

-----------------------
-- Windows and focus --
-----------------------

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
-- Your old bind was `fullscreenstate, 0` (one argument); the new API needs both values.
-- This is the usual "fake fullscreen" (client thinks it is fullscreen, layout unchanged).
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))

for _, d in ipairs({ "left", "right", "up", "down" }) do
    hl.bind("SUPER + " .. d,            hl.dsp.focus({ direction = d }))
    hl.bind("SUPER + SHIFT + " .. d,    hl.dsp.window.move({ direction = d }))
end
hl.bind("SUPER + BracketLeft",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + BracketRight", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Dwindle split ratio
hl.bind("SUPER + Minus",      hl.dsp.layout("splitratio -0.1"), repeating)
hl.bind("SUPER + Equal",      hl.dsp.layout("splitratio 0.1"),  repeating)
hl.bind("SUPER + Semicolon",  hl.dsp.layout("splitratio -0.1"), repeating)
hl.bind("SUPER + Apostrophe", hl.dsp.layout("splitratio 0.1"),  repeating)

-- Mouse move / resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   mouse)
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), mouse)
hl.bind("SUPER + Z",         hl.dsp.window.drag(),   mouse)

----------------
-- Workspaces --
----------------

for i = 1, 10 do
    local key = i % 10 -- 10 -> key 0
    hl.bind("SUPER + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Go to workspace
hl.bind("CTRL + SUPER + Right",        hl.dsp.focus({ workspace = "+1" }))
hl.bind("CTRL + SUPER + Left",         hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + BracketRight", hl.dsp.focus({ workspace = "+1" }))
hl.bind("CTRL + SUPER + BracketLeft",  hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + Down",         hl.dsp.focus({ workspace = "+5" }))
hl.bind("CTRL + SUPER + Up",           hl.dsp.focus({ workspace = "-5" }))
hl.bind("SUPER + Page_Down",           hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + Page_Up",             hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + Page_Down",    hl.dsp.focus({ workspace = "+1" }))
hl.bind("CTRL + SUPER + Page_Up",      hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + mouse_up",            hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + mouse_down",          hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + mouse_up",     hl.dsp.focus({ workspace = "+1" }))
hl.bind("CTRL + SUPER + mouse_down",   hl.dsp.focus({ workspace = "-1" }))

-- Move window to adjacent workspace
hl.bind("SUPER + ALT + Page_Down",         hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + ALT + Page_Up",           hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + Page_Down",       hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + SHIFT + Page_Up",         hl.dsp.window.move({ workspace = "-1" }))
hl.bind("CTRL + SUPER + SHIFT + Right",    hl.dsp.window.move({ workspace = "+1" }))
hl.bind("CTRL + SUPER + SHIFT + Left",     hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + mouse_up",        hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + SHIFT + mouse_down",      hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + ALT + mouse_up",          hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + ALT + mouse_down",        hl.dsp.window.move({ workspace = "-1" }))

-- Special workspace (scratchpad)
hl.bind("SUPER + S",        hl.dsp.workspace.toggle_special("special"))
hl.bind("CTRL + SUPER + S", hl.dsp.workspace.toggle_special("special"))
hl.bind("SUPER + ALT + S",              hl.dsp.window.move({ workspace = "special:special", follow = false }))
hl.bind("CTRL + SHIFT + SUPER + Up",    hl.dsp.window.move({ workspace = "special:special", follow = false }))
