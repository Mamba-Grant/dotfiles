------------------
-- Window rules --
------------------

local office_apps = "^(Microsoft (Word|Excel|PowerPoint|Publisher|Powershell|Visual Studio))$"

hl.window_rule({ name = "wps-tile", match = { class = "(wpsoffice)" }, tile = true })

-- Dialogs float
hl.window_rule({
    name  = "float-file-dialogs",
    match = { title = "^(Open File|Select a File|Choose wallpaper|Open Folder|Save As|Library)(.*)$" },
    float = true,
})

-- Workspace placement
-- Vesktop's class is "vesktop", so this still only matches the official Discord client.
-- Use "^(discord|vesktop)$" if you want Vesktop moved to workspace 7 too.
hl.window_rule({ name = "discord-ws7", match = { class = "^(discord)$" },        workspace = "7 silent" })
hl.window_rule({ name = "spotify-ws5", match = { class = "^([Ss]potify)$" },     workspace = "5 silent" })
hl.window_rule({ name = "obs-ws9",     match = { class = "^(com.obsproject.Studio)$" }, workspace = "9" })

-- Translucency (active inactive). Translucent windows are composited with blending;
-- drop the firefox entry if it ever feels laggy on battery.
hl.window_rule({ name = "opacity-terminals-browser-files",
    match = { class = "^(foot|kitty|firefox|org.gnome.Nautilus)$" }, opacity = "0.9 0.7" })
hl.window_rule({ name = "opacity-editor-music",
    match = { class = "^([Nn]eovide|[Ss]potify)$" }, opacity = "0.9 0.8" })

-- Winapps office windows: ignore maximize/fullscreen requests
hl.window_rule({ name = "office-suppress", match = { class = office_apps }, suppress_event = "maximize fullscreen" })

-- xwaylandvideobridge: keep it invisible
hl.window_rule({
    name             = "xwaylandvideobridge",
    match            = { class = "^(xwaylandvideobridge)$" },
    opacity          = "0.0 override",
    no_anim          = true,
    no_initial_focus = true,
    max_size         = "1 1",
    no_blur          = true,
})

-----------------
-- Layer rules --
-----------------

hl.layer_rule({ name = "xray-all",     match = { namespace = ".*" }, xray = true })
hl.layer_rule({ name = "noanim-tools", match = { namespace = "^(selection|anyrun)$" }, no_anim = true })
hl.layer_rule({ name = "fuzzel",       match = { namespace = "launcher" },        blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "gtk-layer",    match = { namespace = "gtk-layer-shell" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ name = "notifs",       match = { namespace = "notifications" },   blur = true, ignore_alpha = 0.69 })

-- Caelestia (same as caelestia-dots). Its blur/ignore_alpha for "caelestia-drawers"
-- are set at runtime by the shell itself, so they are intentionally not repeated here.
hl.layer_rule({ name = "caelestia-noanim", match = { namespace = "caelestia-(border-exclusion|area-picker)" }, no_anim = true })
hl.layer_rule({ name = "caelestia-fade",   match = { namespace = "caelestia-(drawers|background)" }, animation = "fade" })

-- Dropped (leftovers from the old ags/eww/end-4 setup, no longer running): rules for
-- eww, overview, sideleft, sideright, session and the literal "noanim" namespace.
