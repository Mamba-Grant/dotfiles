{
  description = "Mamba's First Hyprland Flake - Created using JaKooLit's dotfiles as a base";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
    };
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    NixVirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nvf.url = "./nvf/"; # Local flake for nvf
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
    NixVirt,
    nixvim,
    ...
  }: let
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
    vesta = pkgs.callPackage ./vesta/vesta.nix {};
  in {
    packages = {
      default = vesta;
      vesta = vesta;
    };
    apps = {
      default = flake-utils.lib.mkApp {
        drv = vesta;
        name = "VESTA";
      };
    };
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
          # Import the Cisco VPN NixOS module
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
