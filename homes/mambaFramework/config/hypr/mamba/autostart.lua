local vars = require("mamba.vars")

hl.on("hyprland.start", function()
    hl.exec_cmd("caelestia-shell")
    hl.exec_cmd('tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"')
    hl.exec_cmd("easyeffects --gapplication-service")

    -- Clipboard history (used by SUPER + V)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)

    -- Removed: `dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP`.
    -- Home Manager's generated startup hook already does this (wayland.windowManager.hyprland.systemd).
end)
