let
  username = "mamba";
  # homeDirectory = "/home/mamba";
in
  {
    pkgs,
    system,
    inputs,
    # caelestia-cli,
    # caelestia-shell,
    ...
  }: {
    imports = [
      ./dotfiles.nix
      ./gtk.nix
      ./mpv.nix
      ./mimelist.nix
      ./nixvim.nix
      ./hyprland.nix
    ];

    home.packages = [
      pkgs.rofi
      # pkgs.quickshell
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
        # sessionVariables.QML2_IMPORT_PATH = "
        #   ${inputs.caelestia-shell.packages.${pkgs.system}.default}/share/caelestia-shell/qml
        #   ${inputs.quickshell.packages.${pkgs.system}.default}/share/quickshell/qml
        #   ${pkgs.qt6.qtbase}/lib/qt-6/qml
        # ";
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
