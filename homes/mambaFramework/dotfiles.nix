{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.enable = true;

  xdg.configFile = {
    "ags".source = ./config/ags;
    "foot".source = ./config/foot;
    "fuzzel".source = ./config/fuzzel;
    "thorium-flags.conf".source = ./config/thorium-flags.conf;
    "starship.toml".source = ./config/starship.toml;
    # "hypr".source = ./config/hyprExtras;
    # "waybar".source = ./config/waybar;
    "nwg-look".source = ./config/nwg-look;
    "Thunar".source = ./config/Thunar;
    "zathura".source = ./config/zathura;
    "rofi".source = ./config/rofi;
    # "quickshell".source = ./config/quickshell;
  };
}
