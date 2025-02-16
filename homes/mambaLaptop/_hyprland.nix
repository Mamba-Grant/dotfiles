{ pkgs, inputs, ...}: let
in {
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  # environment.etc."hypr/hyprland.conf".text = ''
  #   # Modifier key
  #   $mod = SUPER
  #
  #   # Keybindings
  #   bind = $mod, F, exec, firefox
  #   bind = , Print, exec, grimblast copy area
  #
  #   # Workspaces
  #   ${builtins.concatStringsSep "\n" (builtins.genList (i:
  #     let ws = i + 1;
  #     in ''
  #       bind = $mod, code:1${toString i}, workspace, ${toString ws}
  #       bind = $mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}
  #     ''
  #   ) 9)}
  # '';
  #
  # environment.systemPackages = with pkgs; [
  #   grimblast  # Screenshot tool
  #   xdg-desktop-portal-hyprland  # Portal support
  # ];
}
