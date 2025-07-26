# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options
{
  pkgs,
  inputs,
  ...
}: let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        numpy
        scipy
        matplotlib
        iminuit
        jupyter-core
        jupyterlab
        jupyter-console
      ]
  );
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      grc
      ani-cli
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
      wget
      xdg-user-dirs
      xdg-utils

      fastfetch
      (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      looking-glass-client
      virt-manager
      quickemu
      zoom-us

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
      foot
      blink
      libsForQt5.qtstyleplugin-kvantum #kvantum
      networkmanagerapplet
      nwg-look
      kdePackages.dolphin
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
      system-config-printer
      rofi-wayland
      slurp
      loupe
      flameshot
      wezterm
      gwyddion
      inkscape
      distrobox
      docker
      swaynotificationcenter
      dbus
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      file-roller
      yad
      yt-dlp
      usbutils
      openconnect
      hidapi

      # Applications
      vesktop
      obsidian
      dropbox
      zathura
      libreoffice-qt-fresh
      wpsoffice
      hunspell
      jdk # needed by libreoffice-qt6-fresh
      fend
      zotero
      obs-studio
      davinci-resolve-studio

      # Misc/Development
      tectonic
      julia
      devenv
      screen

      #waybar  # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];

  # FONTS
  fonts.packages = with pkgs; [
    vistafonts
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    font-awesome
    terminus_font
    google-fonts
    fira-code
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.dejavu-sans-mono
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
      thunar-dropbox-plugin
      thunar-volman
      tumbler
    ];

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
