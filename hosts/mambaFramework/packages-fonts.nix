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
      # ─── Core System Utilities ─────────────────────────────────────────────────
      btrfs-progs # Btrfs filesystem tools
      clang # C/C++ compiler toolchain
      cmake # Build system generator
      curl # HTTP/URL transfer tool
      cpufrequtils # CPU frequency scaling utilities
      duf # Disk usage/free utility (modern du/df replacement)
      eza # Modern ls replacement
      file-roller # Archive manager
      glib # GLib core library (required for gsettings)
      gsettings-qt # Qt bridge for GSettings
      grc # Generic colorizer for terminal output
      killall # Kill processes by name
      openssl # TLS/SSL library (required by Rainbow borders)
      pciutils # PCI device utilities (lspci, etc.)
      sshfs # SSH filesystem mounting
      usbutils # USB device utilities (lsusb, etc.)
      wget # File downloader
      xdg-user-dirs # XDG user directory management
      xdg-utils # XDG desktop integration utilities
      unzip # ZIP archive extraction

      # ─── Hyprland / Wayland Compositor ────────────────────────────────────────
      ags # Aylur's widget shell (v1; defined in flake.nix)
      brightnessctl # Screen/keyboard brightness control
      btop # Interactive system resource monitor
      cava # Terminal audio visualizer
      cliphist # Wayland clipboard history manager
      dbus # D-Bus inter-process communication daemon
      grim # Wayland screenshot tool
      gtk-engine-murrine # GTK2 engine required for some GTK themes
      hypridle # Hyprland idle daemon (requires unstable channel)
      imagemagick # CLI image manipulation
      inxi # System information tool
      jq # JSON processor
      networkmanagerapplet # NetworkManager system tray applet
      nss_latest # Mozilla NSS (latest, for security-sensitive apps)
      nwg-look # GTK settings editor for wlroots compositors
      pamixer # PulseAudio/Pipewire CLI mixer
      pavucontrol # PulseAudio volume control GUI
      playerctl # MPRIS media player controller
      polkit_gnome # GNOME polkit authentication agent
      pyprland # Hyprland plugin/scripting layer
      slurp # Wayland region/window selector
      swaynotificationcenter # Notification center for sway/Hyprland
      swww # Animated wallpaper daemon for Wayland
      wallust # Wallpaper-based color scheme generator
      wl-clipboard # Wayland clipboard CLI utilities
      wlogout # Wayland logout menu
      yad # Yet Another Dialog (GTK dialog tool)

      # ─── Terminal & Shell Utilities ───────────────────────────────────────────
      aspell # Spell checker
      fastfetch # Fast system info fetcher (neofetch alternative)
      ffmpeg # Audio/video encoding and processing
      foot # Minimal Wayland terminal emulator
      screen # Terminal multiplexer
      wezterm # GPU-accelerated terminal emulator
      yt-dlp # YouTube/media downloader

      # ─── Fonts & Display ──────────────────────────────────────────────────────
      libappindicator # System tray indicator library
      libnotify # Desktop notification library

      # ─── GUI Applications ─────────────────────────────────────────────────────
      baobab # Disk usage analyzer (GNOME)
      # blink # Blink video calling app
      eog # Eye of GNOME image viewer
      # flameshot # Screenshot tool with annotation
      gnome-system-monitor # GNOME system monitor
      gwyddion # SPM/AFM data analysis and visualization
      inkscape # Vector graphics editor
      loupe # GNOME image viewer (modern)

      # ─── Productivity & Office ────────────────────────────────────────────────
      obsidian # Markdown-based knowledge management
      zathura # Minimal document viewer
      libreoffice-qt-fresh # LibreOffice (Qt build, latest)
      wpsoffice # WPS Office suite
      # kdePackages.calligra # KDE office/drawing suite
      hunspell # Spell checking library (used by office apps)
      jdk # Java Development Kit (required by libreoffice-qt6-fresh)
      fend # Interactive calculator/unit converter
      zotero # Reference manager and academic citation tool

      # ─── Multimedia & Creative ────────────────────────────────────────────────
      obs-studio # Open Broadcaster Software for recording/streaming
      davinci-resolve-studio # Professional video editor
      (mpv.override {scripts = [mpvScripts.mpris];}) # MPV with MPRIS tray support

      # ─── Communication ────────────────────────────────────────────────────────
      vesktop # Unofficial Discord client (Vencord-based)
      zoom-us # Zoom video conferencing

      # ─── Cloud & File Sync ────────────────────────────────────────────────────
      dropbox # Dropbox cloud storage client

      # ─── Virtualization & Containers ──────────────────────────────────────────
      distrobox # Run other Linux distros in containers
      docker # Container runtime
      looking-glass-client # Low-latency VM display for GPU passthrough
      quickemu # Quick VM manager (QEMU wrapper)
      virt-manager # Libvirt-based VM manager GUI

      # ─── Security & Authentication ────────────────────────────────────────────
      hidapi # HID device access library
      yubikey-manager # YubiKey configuration tool
      yubikey-personalization

      # ─── Remote Access ────────────────────────────────────────────────────────
      freerdp # Remote Desktop Protocol client

      # ─── Printing ─────────────────────────────────────────────────────────────
      gtklp # GTK-based CUPS print dialog
      system-config-printer # Printer configuration GUI

      # ─── Development & Scientific ─────────────────────────────────────────────
      devenv # Reproducible development environments (Nix-based)
      hyprpicker # Hyprland color picker
      julia # Julia scientific programming language
      tectonic # Self-contained LaTeX compiler
      ani-cli # CLI tool for streaming/downloading anime

      # ─── Theming & Customization ──────────────────────────────────────────────
      github-desktop # GitHub GUI client
      gparted # Partition editor GUI
      ovito # Scientific data visualization (atoms/molecules)
      temurin-jre-bin-17 # Eclipse Temurin JRE 17

      # ─── Commented-out / Optional ─────────────────────────────────────────────
      # openconnect # VPN client (Cisco AnyConnect-compatible)
      # libsForQt5.qtstyleplugin-kvantum  # Kvantum Qt5 theme engine
      # libsForQt5.qt5ct                  # Qt5 configuration tool
      # kdePackages.qt6ct                 # Qt6 configuration tool
      # kdePackages.qtwayland             # Qt6 Wayland platform plugin
      # kdePackages.qtstyleplugin-kvantum # Kvantum Qt6 theme engine
      # quickshell                        # Quick shell (alternative to ags)
      # waybar                            # Wayland status bar
      # (pkgs.waybar.overrideAttrs (oldAttrs: {  # Waybar with experimental features
      #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      # }))
    ])
    ++ [
      python-packages # Defined separately (see python-packages expression)
    ];

  # FONTS
  fonts.packages = with pkgs; [
    vista-fonts
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
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    # waybar.enable = true;
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

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

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
