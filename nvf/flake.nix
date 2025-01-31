{
  description = "Neovim Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, flake-utils, nvf, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              neovim = (nvf.lib.neovimConfiguration {
                pkgs = final;
                modules = [ ./nvf-configuration.nix ];
              }).neovim;
            })
          ];
        };
      in {
        defaultPackage = pkgs.neovim;
      }
    ) // {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nvf.nixosModules.default
        ];
      };
    };
}
