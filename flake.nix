{
  description = "Mamba's First Hyprland Flake - Created using JaKooLit's dotfiles as a base";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    distro-grub-themes,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";
    host = "default";
    username = "mamba";
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
            home-manager.backupFileExtension = "old";
            home-manager.sharedModules = [nixvim.homeManagerModules.nixvim];
          }
        ];
      };
    };
    homeConfigurations."mamba@mambaLaptop" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          wayland.windowManager.hyprland = {
            enable = true;
            # set the flake package
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };
        }
        # ...
      ];
    };
  };
}
