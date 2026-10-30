{
  description = "Mamba's First Hyprland Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.52.1-b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.caelestia-shell.follows = "";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    distro-grub-themes,
    nixvim,
    caelestia-shell,
    caelestia-cli,
    quickshell,
    ...
  }: let
    system = "x86_64-linux";
    host = "mambaFramework";
    username = "mamba";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system inputs username host;
      };
      modules = [
        {nixpkgs.pkgs = pkgs;}
        ./hosts/mambaFramework/configuration.nix
        inputs.distro-grub-themes.nixosModules.${system}.default
        ({
          pkgs,
          system ? pkgs.system,
          ...
        }: {
          environment.systemPackages = [
            inputs.winapps.packages."${system}".winapps
            inputs.winapps.packages."${system}".winapps-launcher
          ];

          nix.settings = {
            substituters = [
              "https://winapps.cachix.org/"
              "https://hyprland.cachix.org"
            ];
            trusted-public-keys = [
              "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g="
              "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            ];
            trusted-users = ["mamba"];
          };
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username}.imports = [
            ./homes/mambaFramework/home.nix
          ];
          home-manager.extraSpecialArgs = {
            inherit inputs system;
          };
          home-manager.backupFileExtension = "old";
          home-manager.sharedModules = [nixvim.homeModules.nixvim];
        }
      ];
    };
  };
}
