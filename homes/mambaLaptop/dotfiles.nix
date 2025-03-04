{ inputs, config, lib, pkgs, ... }:

{
    xdg.enable = true;

    xdg.configFile = {
        "ags".source = ./config/ags;
        # "fish".source = ./config/fish;
        "foot".source = ./config/foot;
        "fuzzel".source = ./config/fuzzel;
        "mpv".source = ./config/mpv;
        "thorium-flags.conf".source = ./config/thorium-flags.conf;    
        "starship.toml".source = ./config/starship.toml;
        "hypr".source = ./config/hypr;
        "waybar".source = ./config/waybar;
        "nwg-look".source = ./config/nwg-look;
        # "libreoffice" = {
        #     source = ./config/libreoffice;
        #     force = true;
        # };
        "Thunar".source = ./config/Thunar;
        "zathura".source = ./config/zathura;
        "rofi".source = ./config/rofi;
    };
}
