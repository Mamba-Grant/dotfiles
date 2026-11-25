local vars = require("mamba.vars")

-- Cursor
hl.env("HYPRCURSOR_THEME", vars.cursorTheme)
hl.env("XCURSOR_THEME", vars.cursorTheme)
hl.env("XCURSOR_SIZE", tostring(vars.cursorSize))

-- Toolkits
hl.env("QT_QPA_PLATFORM", "wayland;xcb") -- was "wayland"; the xcb fallback keeps Qt apps without a wayland plugin working
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("GDK_SCALE", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.env("EDITOR", "nvim")

-- Dropped: WLR_NO_HARDWARE_CURSORS, WLR_RENDERER_ALLOW_SOFTWARE (wlroots-only, Hyprland ignores
-- them) and XWAYLAND_DPI (nothing in Hyprland reads it).
