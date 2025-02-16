{ inputs, self, config, lib, pkgs, ... }:

{
    home.username = "mamba";   # Ensure the username is set
    home.homeDirectory = "/home/mamba";   # Ensure the home directory is set
    home.stateVersion = "24.11";  # Set this to match your NixOS version
    programs.home-manager.enable = true;
    home-manager.backupFileExtension = "old";
    home-manager.useGlobalPkgs = true;
    home-mamager.extraSpecialArgs = {
      inherit inputs self;
    };

    imports = [
        # Cachix
        # ./cachix.nix
        ## Dotfiles (manual)
        ./dotfiles.nix
        # Stuff
        # ./ags.nix
        # ./anyrun.nix
        # ./browser.nix
        # ./dconf.nix
        # ./hyprland.nix
        # ./mimelist.nix
        # ./packages.nix
        # ./starship.nix
        # ./sway.nix
        # ./theme.nix
    ];
}
