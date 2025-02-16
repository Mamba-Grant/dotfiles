{ inputs, config, lib, pkgs, ... }:

{
    home.username = "mamba";   # Ensure the username is set
    home.homeDirectory = "/home/mamba";   # Ensure the home directory is set
    home.stateVersion = "24.11";  # Set this to match your NixOS version
    programs.home-manager.enable = true;

    imports = [
        # ./firefox.nix
        # ./hyprland.nix
        # ./dotfiles.nix
    ];
}
