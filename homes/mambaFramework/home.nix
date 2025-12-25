let
  username = "mamba";
  homeDirectory = "/home/mamba";
in
  {pkgs, ...}: {
    imports = [
      ## Dotfiles (manual)
      ./dotfiles.nix
      ./gtk.nix
      ./mpv.nix
      ./mimelist.nix
      ./nixvim.nix
    ];

    home = {
      inherit username homeDirectory;
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
