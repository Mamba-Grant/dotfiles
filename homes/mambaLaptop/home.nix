let
    username = "mamba";
    homeDirectory = "/home/mamba";
in { pkgs, ... }: {
    imports = [
        # Cachix
        # ./cachix.nix
        ## Dotfiles (manual)
        ./dotfiles.nix
            ./gtk.nix
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

    home = {
        inherit username homeDirectory;
        sessionVariables = {
            NIXPKGS_ALLOW_UNFREE = "1";
            NIXPKGS_ALLOW_INSECURE = "1";
            XCURSOR_SIZE = "24";
            # Gaming
            # STEAM_EXTRA_COMPAT_TOOLS_PATHS =
            #   "\${HOME}/.steam/root/compatibilitytools.d";
            # STEAMLIBRARY = "\${HOME}/.steam/steam";
            # PROTON_EXPERIMENTAL =
            #   "\${HOME}/.local/share/Steam/steamapps/common/Proton - Experimental";
            # PROTON_GE = "\${STEAM_EXTRA_COMPAT_TOOLS_PATHS}/Proton-GE";
            # PROTON = "\${PROTON_EXPERIMENTAL}";
            # Other variables
            # NIX_BUILD_SHELL = "fish";
        };
        sessionPath = [ "$HOME/.local/bin" ];
    };

    xdg.userDirs = { createDirectories = true; };
    # xdg.mime.enable = true;

        # gtk = {
        #     font = {
        #         name = "Rubik";
        #         package = pkgs.google-fonts.override { fonts = [ "Rubik" ]; };
        #         size = 11;
        #     };
        # };

        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "x-scheme-handler/terminal" = "foot.desktop";
            };
        };

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
        home.stateVersion =
            "24.11"; # this must be the version at which you have started using the program
    }
