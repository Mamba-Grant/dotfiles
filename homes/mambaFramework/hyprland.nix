{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprpicker
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Lua modules, loaded via `require("mamba")` below -> ~/.config/hypr/mamba/init.lua.
  # Editing them needs a rebuild + `hyprctl reload` (SUPER+CTRL+H).
  xdg.configFile."hypr/mamba".source = ./config/hypr/mamba;

  wayland.windowManager.hyprland = {
    enable = true;
    package = null; # set to null when I define in my NixOS flake
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # home.stateVersion is 25.05, which defaults to hyprlang, so this must be explicit.
    configType = "lua";

    # Home Manager still generates hyprland.lua (systemd/dbus startup hook) and appends this.
    extraConfig = ''
      require("mamba")
    '';
  };
}
