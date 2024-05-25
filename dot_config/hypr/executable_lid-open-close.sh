
###################################################
#                   MONITORS                      #
###################################################

# monitor = eDP-1,1440x900,0x0,1
monitor = eDP-1,1440x900,0x0,1
# monitor = eDP-1,1920x1200,0x0,1
monitor = HDMI-A-1,1920x1080@120,1x0,1
monitor = DP-1,1920x1080@120,1920x0,1

###################################################
#                   AUTOSTART                     #
###################################################

exec-once = lxpolkit
exec-once = gammastep -P -O 3700
exec-once = easyeffects --gapplication-service
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store
exec-once = xhost + local:
exec-once = ~/.config/swaylock/lock-if-inactive.sh
exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1

exec = pgrep waybar || waybar
exec = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec = gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
exec = gsettings set org.gnome.desktop.interface gtk-theme 'RosePine-Main-BL'
exec = gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
exec = [ "$(pgrep swaybg)" = 0 ] && pkill swaybg; swaybg -i ~/Pictures/Wallpapers/1440x900/13.png
# exec = [ "$(pgrep swaybg)" = 0 ] && pkill swaybg; swaybg -i ~/Downloads/rsz_waltuh.png
exec = dunst &

###################################################
#                   GENERAL                       #
###################################################

general {
    border_size = 2
    gaps_in = 5
    gaps_out = 5
    col.active_border = rgb(A4C5D6)
    cursor_inactive_timeout = 60
    resize_on_border = true
}

###################################################
#                   DECORATIONS                   #
###################################################

decoration {
    rounding = 5
    blur=1
    blur_size=5.8
    blur_passes=2
    blur_new_optimizations = true
    drop_shadow = false
}

###################################################
#                   ANIMATIONS                    #
###################################################

animations {
    bezier=overshot,0.05,0.9,0.1,1
    enabled = yes
    animation = windows, 1, 3, default, popin
    animation = windowsIn, 1, 3, default, popin 90%
    animation = windowsOut, 1, 3, default, popin
    animation = windowsMove, 1, 3, default, popin
    animation = workspaces, 1, 4, overshot, slide
}

###################################################
#                   INPUT                         #
###################################################

input {
    kb_layout = us,ru 
    kb_variant = 
    kb_model = 
    kb_options = grp:win_space_toggle
    kb_rules =
    follow_mouse = 1
    repeat_rate = 25
    repeat_delay = 200
    sensitivity = 0.4
    accel_profile = "adaptive"

    touchpad {
        natural_scroll = true
        scroll_factor = 0.2
    }
}

device:logitech-g203-lightsync-gaming-mouse {
    sensitivity = -0.4
    accel_profile = "adaptive"
}

###################################################
#                   GESTURES                      #
###################################################

gestures {
    workspace_swipe                     = on
    workspace_swipe_fingers             = 3
    workspace_swipe_distance            = 1000
    workspace_swipe_invert              = true
    workspace_swipe_min_speed_to_force  = 30
    workspace_swipe_cancel_ratio        = 0.5
    workspace_swipe_create_new          = true
    workspace_swipe_forever             = true
    workspace_swipe_numbered            = false
}

###################################################
#                   MISC                          #
###################################################

misc {
    disable_hyprland_logo = true
    animate_manual_resizes = true
}

###################################################
#                   BINDS                         #
###################################################

binds {
    workspace_back_and_forth = true
    allow_workspace_cycles = false
}

# Close / Open Lid
bindl = , switch:Lid Switch, exec, bash ~/.config/hypr/lid-open-close.sh

###################################################
#                  WINDOW RULES                   #
###################################################

windowrule = float, imv
windowrule = float, Thunar
windowrule = float, thunar
windowrule = float, zenity
windowrule = float, file-roller
# windowrule = float, pavucontrol
windowrule = float, gnome-disks
windowrule = float, nwg-look
windowrule = float, qt5ct
windowrule = float, qt6ct
windowrule = float, obs
windowrule = float, org.pwmt.zathura

windowrule = tile, Spotify

windowrule = workspace 1, Steam
windowrule = workspace 2, Spotify
windowrule = workspace 3, google-chrome
windowrule = workspace 5, discord
windowrule = workspace 7, obs
windowrule = workspace 8, firefox
windowrule = workspace 9, qbittorrent
windowrule = workspace 4, org.telegram.desktop

windowrule = opacity 0.90, Obsidian
windowrule = opacity 0.90, Thunar
windowrule = opacity 0.90, thunar
windowrule = opacity 0.90, rofi
windowrule = opacity 0.90, org.telegram.desktop
windowrule = opacity 0.90, nwg-look
windowrule = opacity 0.90, discord

windowrule = opacity 0.95, code
windowrule = opacity 0.95, qbittorrent

windowrule = opacity 0.85, org.pwmt.zathura
windowrule = opacity 0.85, Spotify
windowrule = opacity 0.80, Rofi
windowrule = opacity 0.80, zenity

windowrule = size 1000 550, Thunar
windowrule = size 1000 550, thunar
windowrule = size 70%, obs

windowrule = center, Thunar
windowrule = center, thunar
windowrule = center, obs
windowrule = center, org.pwmt.zathura


# Telegram image viewer & file picker
windowrulev2 = fullscreen, class:^(org.telegram.desktop)$, title:^(Media viewer)$
windowrulev2 = size 47% 43%, class:^(org.telegram.desktop)$, title:^(Choose files)$
windowrulev2 = center, class:^(org.telegram.desktop)$, title:^(Choose Files)$

#  Google chrome file picker
windowrulev2 = opacity 0.90, class:^(google-chrome)$, title:^(Open Files)$
windowrulev2 = size 70% 60%, class:^(google-chrome)$, title:^(Open Files)$
windowrulev2 = float, center, class:^(google-chrome)$, title:^(Open Files)$

# Spotify image picker
windowrulev2 = opacity 0.90 ,center, class:^(spotify)$, title:^(Open File)$
windowrulev2 = float, center, class:^(spotify)$, title:^(Open File)$

# VS Code file picker
windowrulev2 = opacity 0.90, center, class:^(code)$, title:^(Open File)$
windowrulev2 = float, center, class:^(code)$, title:^(Open File)$

windowrulev2 = float, center, class:^(code)$, title:^(Open Folder)$
windowrulev2 = size 70% 60%, class:^(code)$, title:^(Open Folder)$

# Thunar file operation progress
windowrulev2 = size 30% 10%, class:^(thunar)$, title:^(File Operation Progress)$
windowrulev2 = size 43% 67%, class:^(thunar)$, title:^(Confirm to replace files)$
windowrulev2 = size 576 722, class:^(thunar)$, title:^(File Manager Preferences)$
windowrulev2 = center, class:^(thunar)$, title:^(File Manager Preferences)$
windowrulev2 = size 409 176, class:^(thunar)$, title:^(Attention)$
windowrulev2 = size 609 173, class:^(thunar)$, title:^(Empty Trash)$
windowrulev2 = center, class:^(thunar)$, title:^(Attention)$
windowrulev2 = center, class:^(thunar)$, title:^(Empty Trash)$

# Just apps
windowrulev2 = size 68% 60%, class:^(GParted)$
windowrulev2 = center, class:^(GParted)$
windowrulev2 = float, class:^(GParted)$
windowrulev2 = size 20% 43%, class:^(GParted)$, title:^(gpartedbin)$
windowrulev2 = float, size 80% 65%, class:^(pavucontrol)$

# Firefox sharing indicator
windowrulev2 = workspace special, class:^(firefox)$, title:^(Firefox — Sharing Indicator)$

# Chrome sharing indicator
windowrulev2 = workspace special, title:^(discord.com is sharing your screen.)$

###################################################
#                   DISPATCHERS                   #
###################################################

# Hyprland
bind = CTRL_ALT,    Q, exit
bind = CTRL_ALT,    Delete, exec, systemctl reboot
bind = SUPER_SHIFT, R,      exec, pkill waybar; hyprctl reload
bind = CTRL_SHIFT,  l,      exec, sh ~/.config/swaylock/lock-session.sh
bind = SUPER,       V,      exec, ~/.config/rofi/launchers/clipboard/launch.sh
bind = SUPER_SHIFT, V,      exec, cliphist wipe

# Windows
bind = SUPER,       P, pin
bind = SUPER,       Q, killactive
bind = SUPER,       F, fullscreen
bind = SUPER_SHIFT, F, togglefloating

# Moving windows
bind = SUPER_SHIFT, J,         movewindow, l
bind = SUPER_SHIFT, K,         movewindow, r
bind = SUPER_SHIFT, L,         movewindow, d
bind = SUPER_SHIFT, semicolon, movewindow, u

# Focus
bind = SUPER, J,         movefocus, l
bind = SUPER, K,         movefocus, r
bind = SUPER, L,         movefocus, d
bind = SUPER, semicolon, movefocus, u

# Applications
bind = SUPER,    E,      exec, thunar
bind = CTRL_ALT, D,      exec, discord
bind = CTRL_ALT, S,      exec, env LD_PRELOAD=/home/shved/.local/lib/spotifywm.so /opt/spotify/spotify
bind = CTRL_ALT, C,      exec, google-chrome-stable
bind = SUPER,    Return, exec, ~/.local/bin/alacritty-socket.sh
bind = SUPER,    A,      exec, ~/.config/rofi/launchers/launcher/launcher.sh
bind = SUPER_SHIFT, Return, exec, WINIT_UNIX_BACKEND=x11 alacritty

# Resize windows 
binde = SUPER_SHIFT, left,   resizeactive, -40 0
binde = SUPER_SHIFT, right,  resizeactive, 40 0
binde = SUPER_SHIFT, down,   resizeactive, 0 40
binde = SUPER_SHIFT, up,     resizeactive, 0 -40

# Screenshots
bind = SUPER_SHIFT, S, exec, ~/.local/bin/wayland-screenshot.sh copy area
bind = SUPER_SHIFT, Z, exec, ~/.local/bin/wayland-screenshot.sh copy screen

# Color picker
bind = SUPER_SHIFT, C, exec, ~/.local/bin/color_picker_wayland.sh

# Brightness & volume
binde =,XF86AudioLowerVolume,exec, ~/.local/bin/notifications/volume.sh down
binde =,XF86AudioRaiseVolume,exec, ~/.local/bin/notifications/volume.sh up
binde =,XF86AudioMute,       exec, ~/.local/bin/notifications/volume.sh mute
binde =,XF86AudioStop,       exec, ~/.local/bin/notifications/microphone.sh toggle
binde =,XF86AudioMicMute,    exec, ~/.local/bin/notifications/microphone.sh toggle

binde =,XF86MonBrightnessUp,  exec, ~/.local/bin/notifications/brightness.sh up
binde =,XF86MonBrightnessDown,exec, ~/.local/bin/notifications/brightness.sh down

# Music management
bind =,XF86AudioPrev, exec, playerctl previous
bind =,XF86AudioNext, exec, playerctl next
bind =,XF86AudioPlay, exec, playerctl play-pause
bind =,XF86Tools, exec, env LD_PRELOAD=/home/shved/.local/lib/spotifywm.so /opt/spotify/spotify

# Switch workspaces with mainMod + [0-9]
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
# bind = SUPER, 0, workspace, 10

bind = SUPER, TAB, workspace, previous
bind = CTRL_ALT, Right, workspace, +1
bind = CTRL_ALT, Left, workspace, -1
bind = SUPER, minus, workspace, special

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = SUPER_SHIFT, 1, movetoworkspacesilent, 1
bind = SUPER_SHIFT, 2, movetoworkspacesilent, 2
bind = SUPER_SHIFT, 3, movetoworkspacesilent, 3
bind = SUPER_SHIFT, 4, movetoworkspacesilent, 4
bind = SUPER_SHIFT, 5, movetoworkspacesilent, 5
bind = SUPER_SHIFT, 6, movetoworkspacesilent, 6
bind = SUPER_SHIFT, 7, movetoworkspacesilent, 7
bind = SUPER_SHIFT, 8, movetoworkspacesilent, 8
bind = SUPER_SHIFT, 9, movetoworkspacesilent, 9
# bind = SUPER_SHIFT, 0, movetoworkspacesilent, 10

bind = SUPER_SHIFT, minus, movetoworkspacesilent, special

# Scroll through existing workspaces with mainMod + scroll
bind = SUPER, mouse_down, workspace, e+1
bind = SUPER, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = SUPER, mouse:272, movewindow
bindm = SUPER, mouse:273, resizewindow

# vim:ft=cfg


