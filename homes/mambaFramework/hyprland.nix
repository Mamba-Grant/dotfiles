{
  inputs,
  pkgs,
  prev,
  ...
}: let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  xdg = pkgs.xdg;
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};
in {
  home.packages = with pkgs; [
    hyprpicker
    hyprlock
  ];

  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "QT_QPA_PLATFORM, wayland"
        "QT_QPA_PLATFORMTHEME, qt5ct"
        "QT_STYLE_OVERRIDE,kvantum"
        "WLR_NO_HARDWARE_CURSORS, 1"
      ];
      monitor = [
        ''
          DP-2,preferred,0x0,1
          workspace=5, monitor:DP-2, default:true, persistent:true
          workspace=6, monitor:DP-2, persistent:true
          workspace=7, monitor:DP-2, persistent:true
          workspace=8, monitor:DP-2, persistent:true

          monitor=eDP-1,preferred,1920x0,1
          workspace=10, monitor:eDP-1, default:true, persistent:true
          workspace=9, monitor:eDP-1, persistent:true

          monitor=HDMI-A-1,preferred,0x1080,1
          workspace=1, monitor:HDMI-A-1, default:true, persistent:true
          workspace=2, monitor:HDMI-A-1, persistent:true
          workspace=3, monitor:HDMI-A-1, persistent:true
          workspace=4, monitor:HDMI-A-1, persistent:true


          #monitor=DP-3,1920x1080@60,0x0,1,mirror,DP-2
          #monitor=,preferred,auto,1,mirror,eDP-1
        ''
      ];
      "exec-once" = [
        # "swww img /home/mamba/Pictures/Wallpapers/tora.png"
        # "sh -c 'cd ~/.config/quickshell && qs'"
        "caelestia-shell"
        ''
          tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"
        ''
        "easyeffects --gapplication-service"
        "ags"
        "swww kill; swww init"
        ''
          swayidle -w timeout 2400 'swaylock -f' timeout 2900 'pidof java || systemctl suspend' before-sleep 'swaylock -f'
        ''
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "/.config/ags/scripts/color_generation/switchwall.sh --noswitch"
      ];
      general = {
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "rgba(471868FF)";
        "col.inactive_border" = "rgba(4f4256CC)";
      };
      dwindle = {
        preserve_split = true;
        smart_resizing = false;
      };

      # Gesture bindings

      gesture = [
        "3, horizontal, workspace" # No modifier = workspace switch
        "3, left, mod: ALT, float" # With ALT = float window
        "3, down, mod: ALT, close"
        "3, up, mod: SUPER, fullscreen"
      ];

      # Gesture behavior configuration
      gestures = {
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = false;
      };

      binds = {scroll_event_delay = 0;};
      input = {
        # Keyboard: Add a layout and uncomment kb_options for Win+Space switching shortcut
        kb_layout = "us";
        # kb_variant = "intl";
        # kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
        };

        # special_fallthrough = true   # only in new hyprland versions. but they're hella fucked
        follow_mouse = 1;
      };
      decoration = {
        rounding = 20;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 5;
          passes = 4;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
        };

        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };
      animations = {
        enabled = true;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 7, fluent_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
        ];
      };

      misc = {
        vfr = 1;
        vrr = 1;
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";

        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = 2;
      };
      bind = let
        SLURP_COMMAND = "$(slurp -d -c eedcf5BB -b 4f425644 -s 00000000)";
      in [
        "Super, D, global, caelestia:launcher"
        # "Super, catchall, global, caelestia:launcherInterrupt"
        # "Super, D, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"
        "Super, T, exec, foot --override shell=fish"
        "Super, Return, exec, thunar"
        "Super, Q, killactive, "
        "Control+Shift+Alt, Delete, exec, pkill wlogout || wlogout -p layer-shell"
        "Control+Shift+Alt+Super, Delete, exec, systemctl poweroff"
        ''
          Super+Shift+Alt, S, exec, grim -g "${SLURP_COMMAND}" - | swappy -f -
        ''
        ''
          Super+Shift, S, exec, grim -g "${SLURP_COMMAND}" - | wl-copy
        ''
        "Super+Shift, C, exec, hyprpicker -a"
        "Super, V, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"
        ''
          Control+Super+Shift,S,exec,grim -g "${SLURP_COMMAND}" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png"
        ''
        "Super, L, exec, swaylock"
        "Super+Shift, L, exec, swaylock"
        "Control+Super, Slash, exec, pkill anyrun || anyrun"
        "Super+Alt, f12, exec, notify-send 'Test notification' 'This is a really long message to test truncation and wrapping\\nYou can middle click or flick this notification to dismiss it!' -a 'Shell' -A 'Test1=I got it!' -A 'Test2=Another action'"
        "Super+Alt, Equal, exec, notify-send 'Urgent notification' 'Ah hell no' -u critical -a 'Hyprland keybind'"
        "Super+Shift, left, movewindow, l"
        "Super+Shift, right, movewindow, r"
        "Super+Shift, up, movewindow, u"
        "Super+Shift, down, movewindow, d"
        "Super, left, movefocus, l"
        "Super, right, movefocus, r"
        "Super, up, movefocus, u"
        "Super, down, movefocus, d"
        "Super, BracketLeft, movefocus, l"
        "Super, BracketRight, movefocus, r"
        "Control+Super, right, workspace, +1"
        "Control+Super, left, workspace, -1"
        "Control+Super, BracketLeft, workspace, -1"
        "Control+Super, BracketRight, workspace, +1"
        "Control+Super, up, workspace, -5"
        "Control+Super, down, workspace, +5"
        "Super, Page_Down, workspace, +1"
        "Super, Page_Up, workspace, -1"
        "Control+Super, Page_Down, workspace, +1"
        "Control+Super, Page_Up, workspace, -1"
        "Super+Alt, Page_Down, movetoworkspace, +1"
        "Super+Alt, Page_Up, movetoworkspace, -1"
        "Super+Shift, Page_Down, movetoworkspace, +1"
        "Super+Shift, Page_Up, movetoworkspace, -1"
        "Control+Super+Shift, Right, movetoworkspace, +1"
        "Control+Super+Shift, Left, movetoworkspace, -1"
        "Super+Shift, mouse_down, movetoworkspace, -1"
        "Super+Shift, mouse_up, movetoworkspace, +1"
        "Super+Alt, mouse_down, movetoworkspace, -1"
        "Super+Alt, mouse_up, movetoworkspace, +1"
        "Super, F, fullscreen, 0"
        "Super+Alt, F, fullscreenstate, 0"
        "Super+Shift, F, togglefloating, 0"
        "Super, 1, workspace, 1"
        "Super, 2, workspace, 2"
        "Super, 3, workspace, 3"
        "Super, 4, workspace, 4"
        "Super, 5, workspace, 5"
        "Super, 6, workspace, 6"
        "Super, 7, workspace, 7"
        "Super, 8, workspace, 8"
        "Super, 9, workspace, 9"
        "Super, 0, workspace, 10"
        "Super, S, togglespecialworkspace,"
        "Control+Super, S, togglespecialworkspace,"
        "Super, Tab, cyclenext"
        "Super, Tab, bringactivetotop,"
        "Super+Shift, 1, movetoworkspacesilent, 1"
        "Super+Shift, 2, movetoworkspacesilent, 2"
        "Super+Shift, 3, movetoworkspacesilent, 3"
        "Super+Shift, 4, movetoworkspacesilent, 4"
        "Super+Shift, 5, movetoworkspacesilent, 5"
        "Super+Shift, 6, movetoworkspacesilent, 6"
        "Super+Shift, 7, movetoworkspacesilent, 7"
        "Super+Shift, 8, movetoworkspacesilent, 8"
        "Super+Shift, 9, movetoworkspacesilent, 9"
        "Super+Shift, 0, movetoworkspacesilent, 10"
        "Control+Shift+Super, Up, movetoworkspacesilent, special"
        "Super+Alt, S, movetoworkspacesilent, special"
        "Super, mouse_up, workspace, +1"
        "Super, mouse_down, workspace, -1"
        "Control+Super, mouse_up, workspace, +1"
        "Control+Super, H, exec, hyprctl reload"
      ];
      bindm = [
        "Super, mouse:272, movewindow"
        "Super, mouse:273, resizewindow"
        "Super, Z, movewindow"
      ];
      bindl = [
        # ",XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
        # "Super+Shift,M, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
        # ",Print,exec,grim - | wl-copy"
        # ''
        #   Super+Shift, N, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`''
        # ''
        #   ,XF86AudioNext, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`''
        # "Super+Shift, B, exec, playerctl previous"
        # ",XF86AudioPrev, exec, playerctl previous"
        # "Super+Shift, P, exec, playerctl play-pause"
        # ",XF86AudioPlay, exec, playerctl play-pause"
        # "Super+Shift, L, exec, sleep 0.1 && systemctl suspend"
        # ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindle = [
        # Brightness
        ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
        ", XF86MonBrightnessDown, global, caelestia:brightnessDown"

        # Media
        "Ctrl+Super, Space, global, caelestia:mediaToggle"
        ", XF86AudioPlay, global, caelestia:mediaToggle"
        ", XF86AudioPause, global, caelestia:mediaToggle"
        "Ctrl+Super, Equal, global, caelestia:mediaNext"
        ", XF86AudioNext, global, caelestia:mediaNext"
        "Ctrl+Super, Minus, global, caelestia:mediaPrev"
        ", XF86AudioPrev, global, caelestia:mediaPrev"
        ", XF86AudioStop, global, caelestia:mediaStop"
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindr = [
        # Kill/restart
        "Ctrl+Super+Shift, R, exec, qs -c caelestia kill"
        "Ctrl+Super+Alt, R, exec, qs -c caelestia kill; caelestia shell -d"
      ];
      binde = [
        "Super, Minus, splitratio, -0.1"
        "Super, Equal, splitratio, 0.1"
        "Super, Semicolon, splitratio, -0.1"
        "Super, Apostrophe, splitratio, 0.1"
      ];
      windowrule = [
        "float,title:^(Open File)(.*)$"
        "float,title:^(Select a File)(.*)$"
        "float,title:^(Choose wallpaper)(.*)$"
        "float,title:^(Open Folder)(.*)$"
        "float,title:^(Save As)(.*)$"
        "float,title:^(Library)(.*)$ "
      ];
      windowrulev2 = [
        "tile,class:(wpsoffice)"
        "workspace 7 silent, class:^(discord)$"
        "workspace 5 silent, class:^([Ss]potify)$"
        "workspace 9, class:^(com.obsproject.Studio)$"
        "opacity 0.9 0.7, class:^(foot)$"
        "opacity 0.9 0.7, class:^(kitty)$"
        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "opacity 0.9 0.7, class:^(firefox)$"
        "opacity 0.9 0.7, class:^(org.gnome.Nautilus)$"
        "opacity 0.9 0.8, class:^([Nn]eovide)$"
        "opacity 0.9 0.8, class:^([Ss]potify)$"
      ];
      layerrule = [
        "xray 1, .*"
        "noanim, selection"
        "noanim, overview"
        "noanim, anyrun"
        "blur, swaylock"
        "blur, eww"
        "ignorealpha 0.8, eww"
        "noanim, noanim"
        "blur, noanim"
        "blur, gtk-layer-shell"
        "ignorezero, gtk-layer-shell"
        "blur, launcher"
        "ignorealpha 0.5, launcher"
        "blur, notifications"
        "ignorealpha 0.69, notifications"
        "blur, session"
        "noanim, sideright"
        "noanim, sideleft"
      ];
    };
  };
}
