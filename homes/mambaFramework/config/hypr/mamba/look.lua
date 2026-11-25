hl.config({
    general = {
        layout           = "dwindle",
        gaps_in          = 4,
        gaps_out         = 5,
        gaps_workspaces  = 50,
        border_size      = 1,
        resize_on_border = true,
        col = {
            active_border   = "rgba(471868FF)",
            inactive_border = "rgba(4f4256CC)",
        },
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = false,
    },

    binds = {
        scroll_event_delay = 0,
    },

    input = {
        kb_layout          = "us",
        numlock_by_default = true,
        repeat_delay       = 250,
        repeat_rate        = 35,
        follow_mouse       = 1,
        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor        = 0.5,
        },
    },

    decoration = {
        rounding     = 20,
        dim_inactive = false,
        dim_strength = 0.1,
        dim_special  = 0,
        blur = {
            enabled           = true,
            xray              = true,
            special           = false,
            new_optimizations = true,
            size              = 5,
            passes            = 4,
            brightness        = 1,
            noise             = 0.01,
            contrast          = 1,
        },
    },

    animations = { enabled = true },

    gestures = {
        workspace_swipe_distance     = 300,
        workspace_swipe_invert       = true,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new   = true,
        workspace_swipe_forever      = false,
    },

    misc = {
        vrr                          = 2,     -- was 1 (always on); 2 = fullscreen only, avoids stutter with browsers/Electron
        focus_on_activate            = true,
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,
        enable_swallow               = false,
        disable_hyprland_logo        = true,
        on_focus_under_fullscreen    = 2,     -- replaces new_window_takes_over_fullscreen
        -- Needed by Caelestia's lock screen
        allow_session_lock_restore   = true,
        session_lock_xray            = true,
        -- Removed: misc.vfr (no longer exists)
    },
})

-- Gestures (3-finger)
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "left", mods = "ALT",   action = "float" })
hl.gesture({ fingers = 3, direction = "down", mods = "ALT",   action = "close" })
hl.gesture({ fingers = 3, direction = "up",   mods = "SUPER", action = "fullscreen" })

-- Animations
hl.curve("md3_decel",    { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("fluent_decel", { type = "bezier", points = { { 0.1, 1 },    { 0, 1 } } })

hl.animation({ leaf = "windows",          enabled = true, speed = 3,   bezier = "md3_decel",    style = "popin 60%" })
hl.animation({ leaf = "border",           enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 2.5, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 7,   bezier = "fluent_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "md3_decel",    style = "slidefadevert 15%" })
