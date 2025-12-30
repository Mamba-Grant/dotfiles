{
  description = "Mamba's First Hyprland Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
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
    forAllSystems = fn:
      nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
        system: fn nixpkgs.legacyPackages.${system}
      );
  in {
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      inherit system;
      # Pass special arguments to modules
      specialArgs = {
        inherit system inputs username host;
      };
      modules = [
        ./hosts/mambaFramework/configuration.nix
        inputs.distro-grub-themes.nixosModules.${system}.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${username}.imports = [
            ./homes/mambaFramework/home.nix
          ];

          home-manager.extraSpecialArgs = {
            inherit inputs system; # can pass inputs to avoid passing packages directly
          };

          home-manager.backupFileExtension = "old";
          home-manager.sharedModules = [nixvim.homeManagerModules.nixvim];
        }
      ];
    };
  };
}
