# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, ...}: let

    python-packages = pkgs.python3.withPackages (
        ps:
        with ps; [
            textual
            textual-dev
            numpy
            scipy
            pyvisa
            pyvisa-sim
            qcodes
            seaborn
            matplotlib
            requests
            iminuit
            pyquery # needed for hyprland-dots Weather script
            jupyterlab
        ]
    );

in {

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = (with pkgs; [
        # System Packages
        grc
        gr-framework
        baobab
        btrfs-progs
        clang
        curl
        cpufrequtils
        duf
        eza
        ffmpeg   
        glib #for gsettings to work
        gsettings-qt
        git
        killall  
        libappindicator
        libnotify
        openssl #required by Rainbow borders
        pciutils
        vim
        wget
        xdg-user-dirs
        xdg-utils

        fastfetch
        (mpv.override {scripts = [mpvScripts.mpris];}) # with tray

        # Hyprland Stuff
        ags # note: defined at flake.nix to download and install ags v1    
        btop
        brightnessctl # for brightness control
        cava
        cliphist
        eog
        gnome-system-monitor
        grim
        gtk-engine-murrine #for gtk themes
        hypridle # requires unstable channel
        imagemagick 
        inxi
        nss_latest
        jq
        # kitty
        foot
        blink
        libsForQt5.qtstyleplugin-kvantum #kvantum
        networkmanagerapplet
        nwg-look
        #nvtopPackages.intel	 
        pamixer
        pavucontrol
        playerctl
        polkit_gnome
        pyprland
        libsForQt5.qt5ct
        kdePackages.qt6ct
        kdePackages.qtwayland
        kdePackages.qtstyleplugin-kvantum #kvantum
        gtklp
        # print-manager
        system-config-printer
        rofi-wayland
        slurp
        swappy
        flameshot
        swaynotificationcenter
        swww
        unzip
        wallust
        wl-clipboard
        wlogout
        # xarchiver
        file-roller
        xfce.thunar-dropbox-plugin
        xfce.thunar-archive-plugin
        yad
        yt-dlp

        # Applications
        vesktop
        ungoogled-chromium
        obsidian
        dropbox
        zathura
        libreoffice-qt6-fresh
        fend
        zotero

        # Misc/Development
        tectonic
        julia

        #waybar  # if wanted experimental next line
        #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ]) ++ [
            python-packages
        ];

    # FONTS
    fonts.packages = with pkgs; [
        noto-fonts
        fira-code
        jetbrains-mono
        noto-fonts-cjk-sans
        font-awesome
        terminus_font
        google-fonts
        nerdfonts
        (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    ];

    programs = {
        hyprland = {
            enable = true;
            #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
            xwayland.enable = true;
        };

        waybar.enable = true;
        hyprlock.enable = true;
        firefox.enable = true;
        git.enable = true;
        nm-applet.indicator = true;

        thunar.enable = true;
        thunar.plugins = with pkgs.xfce; [
            exo
            mousepad
            thunar-archive-plugin
            thunar-volman
            tumbler
        ];

        virt-manager.enable = false;

        #steam = {
        #  enable = true;
        #  gamescopeSession.enable = true;
        #  remotePlay.openFirewall = true;
        #  dedicatedServer.openFirewall = true;
        #};

        xwayland.enable = true;

        dconf.enable = true;
        seahorse.enable = true;
        fuse.userAllowOther = true;
        mtr.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };

    };

    # Extra Portal Configuration
    xdg.portal = {
        enable = true;
        wlr.enable = false;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
        ];
        configPackages = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal
        ];
    };

}
