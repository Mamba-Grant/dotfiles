let
  username = "mamba";
in
  {
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      ./dotfiles.nix
      ./gtk.nix
      ./mpv.nix
      ./mimelist.nix
      ./nixvim.nix
      ./hyprland.nix
      # ./hypridle.nix
    ];

    home.packages = [
      pkgs.rofi
      inputs.caelestia-shell.packages.${pkgs.system}.default
      inputs.caelestia-cli.packages.${pkgs.system}.default
      inputs.quickshell.packages.${pkgs.system}.default
    ];

    home = {
      inherit username;
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        XCURSOR_SIZE = "24";
      };
      sessionPath = ["$HOME/.local/bin"];
    };

    xdg.userDirs = {createDirectories = true;};
    xdg.mime.enable = true;
    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=foot
    '';

    programs = {
      home-manager.enable = true;
      direnv = {
        enable = true;
        enableFishIntegration = true;
        nix-direnv.enable = true;
      };
    };
    home.stateVersion = "25.05";
  }
