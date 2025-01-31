{
    description = "Mamba's First Hyprland Flake - Created using JaKooLit's dotfiles";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
        home-manager.url = "github:nix-community/home-manager";
        ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
        nvf.url = "./nvf/"; # Local flake for nvf
    };

    outputs = inputs @ { self, nixpkgs, distro-grub-themes, ... }: let
        # System and host variables
        system = "x86_64-linux";
        host = "default";
        username = "mamba";

        # Import pkgs with system and custom configuration
        pkgs = import nixpkgs {
            inherit system;
            config = {
                allowUnfree = true;
            };
        };
    in {
        nixosConfigurations = {
            # Define the NixOS configuration for the host
            "${host}" = nixpkgs.lib.nixosSystem {
                inherit system;

                # Pass special arguments to modules
                specialArgs = {
                    inherit system inputs username host;
                };

                modules = [
                    ./hosts/mambaLaptop/configuration.nix
                    inputs.distro-grub-themes.nixosModules.${system}.default
                ];
            };
        };
    };
}

