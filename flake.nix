{
    description = "Mamba's First Hyprland Flake - Created using JaKooLit's dotfiles";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
        nvf.url = "./nvf/"; # Local flake for nvf
        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            # inputs.nixpkgs.follows = "hyprland";
        };
        firefox-gnome-theme = {
            url = "github:rafaelmardojai/firefox-gnome-theme";
            flake = false;
        };
        anyrun = {
            url = "github:Kirottu/anyrun";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { self, nixpkgs, home-manager, distro-grub-themes, ... }: let
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
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.mamba = import homes/mambaLaptop/home.nix;
                    }
                ];
            };
        };
    };
}

