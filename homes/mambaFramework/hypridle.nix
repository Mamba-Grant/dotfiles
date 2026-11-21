{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 2400;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 2900;
          on-timeout = "pidof java || systemctl suspend";
        }
      ];
    };
  };
}
