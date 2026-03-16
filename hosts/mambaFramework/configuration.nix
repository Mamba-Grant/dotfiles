# ============================================================
# NixOS System Configuration
# Template by: https://github.com/JaKooLit
# ============================================================
{
  config,
  pkgs,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  # ============================================================
  # IMPORTS
  # ============================================================
  imports = [
    ./hardware-configuration.nix # Hardware-specific settings (auto-generated)
    ./users.nix # User accounts and groups
    ./packages-fonts.nix # Installed packages and fonts
  ];

  # ============================================================
  # SYSTEM STATE VERSION
  # ============================================================
  # Determines the NixOS release from which default settings for stateful data
  # (e.g. file locations, database versions) were taken. Do not change unless
  # you've read the upgrade docs: https://nixos.org/nixos/options.html
  system.stateVersion = "25.11";

  # ============================================================
  # BOOT & KERNEL
  # ============================================================
  boot = {
    # Use the latest stable Linux kernel
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      # Suppress unnecessary console setup on boot
      "systemd.mask=systemd-vconsole-setup.service"
      # Mask TPM device to avoid a ~1.5 min systemd hang bug
      "systemd.mask=dev-tpmrm0.device"
      # Disable hardware watchdog timers to reduce boot noise
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # Watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # Watchdog for Intel
    ];

    kernelModules = [
      "v4l2loopback" # OBS virtual camera support
      "usbtmc" # USB Test & Measurement Class (e.g. Keithley instruments)
    ];

    initrd = {
      # Modules required for early boot (NVMe, USB, AHCI storage)
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };

    kernel.sysctl = {
      # Required by some Steam games (increases virtual memory map limit)
      "vm.max_map_count" = 2147483642;
    };

    # ---- Bootloader ----
    # Using systemd-boot (EFI). Do NOT enable both systemd-boot and GRUB.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5; # Seconds to wait at boot menu before auto-booting

    # ---- Temporary Filesystem ----
    tmp = {
      useTmpfs = false; # Set true to mount /tmp as tmpfs (RAM-backed)
      tmpfsSize = "30%"; # Max size if tmpfs is enabled
    };

    # ---- AppImage Support ----
    # Allows running AppImage binaries directly via binfmt magic bytes
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    # ---- Plymouth Boot Splash ----
    plymouth.enable = true;
  };

  # ============================================================
  # NIX PACKAGE MANAGER
  # ============================================================
  nix = {
    settings = {
      trusted-users = ["root" "mamba"];
      auto-optimise-store = true; # Automatically deduplicate store paths
      experimental-features = [
        "nix-command" # Enables the unified `nix` CLI
        "flakes" # Enables Nix flakes
      ];
      # Binary cache for Hyprland to avoid recompiling from source
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    gc = {
      automatic = true; # Enable automatic garbage collection
      dates = "weekly"; # Run every week
      options = "--delete-older-than 7d"; # Remove store paths older than 7 days
    };
  };

  # ============================================================
  # NETWORKING
  # ============================================================
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true; # Save battery on WiFi when idle
    # Append pool.ntp.org to default NTP servers for better time sync
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  };

  # Disable the "wait for network" service to shave ~5-6 seconds off boot time
  systemd.services."NetworkManager-wait-online".enable = false;

  # ============================================================
  # LOCALE & TIME
  # ============================================================
  time.timeZone = "US/Eastern"; # See: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

  # Console keymap (matches X11 layout from variables.nix)
  console.keyMap = "${keyboardLayout}";

  # ============================================================
  # DESKTOP & DISPLAY
  # ============================================================
  services.xserver = {
    enable = true;
    xkb = {
      layout = "${keyboardLayout}";
      variant = "";
    };
  };

  # TUI login manager that launches Hyprland on login
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = username;
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  # Enable xfconf (needed for XFCE/Thunar settings persistence)
  programs.xfconf.enable = true;

  # Allow Electron apps (e.g. VS Code, Discord) to use native Wayland rendering
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # ============================================================
  # AUDIO (PipeWire)
  # ============================================================
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Needed for 32-bit apps (Wine, Steam)
    pulse.enable = true; # PulseAudio compatibility layer
    wireplumber.enable = true; # Session/policy manager for PipeWire
  };
  security.rtkit.enable = true; # Realtime priority for audio threads

  # ============================================================
  # BLUETOOTH
  # ============================================================
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket"; # Enable A2DP audio profiles
        Experimental = true; # Enable experimental BT features
      };
    };
  };
  services.blueman.enable = true; # Bluetooth manager GUI/tray applet

  # ============================================================
  # POWER MANAGEMENT
  # ============================================================
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil"; # Responsive governor that follows scheduler hints
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave"; # Conserve energy on battery
        turbo = "never";
      };
      charger = {
        governor = "performance"; # Full speed when plugged in
        turbo = "auto";
      };
    };
  };

  services.upower.enable = true; # Power state daemon (battery info, lid events)

  # ZRAM swap: compressed in-RAM swap to reduce I/O and improve responsiveness
  zramSwap = {
    enable = true;
    priority = 100; # Prefer ZRAM over disk swap
    memoryPercent = 30; # Use up to 30% of RAM for ZRAM
    swapDevices = 1;
    algorithm = "zstd"; # Fast + good compression ratio
  };

  # ============================================================
  # HARDWARE MISC
  # ============================================================
  # Logitech wireless receiver support (disabled — enable if needed)
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Firmware update support (UEFI capsule updates, etc.)
  services.fwupd.enable = true;

  # Periodic SSD TRIM to maintain flash drive performance
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # USBTMC group and udev rules for lab instrument access (e.g. Keithley 2450)
  users.groups.usbtmc = {};
  services.udev.extraRules = ''
    # Keithley 2450 SourceMeter — grant read/write access to usbtmc group
    SUBSYSTEM=="usb", ATTRS{idVendor}=="05e6", ATTRS{idProduct}=="2450", MODE="0666", GROUP="usbtmc", SYMLINK+="keithley2450"

    # Generic USBTMC class devices (class 0xFE, subclass 0x03)
    SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="fe", ATTR{bInterfaceSubClass}=="03", MODE="0666", GROUP="usbtmc"

    # Grant direct ownership of Keithley 2450 to primary user
    SUBSYSTEM=="usb", ATTRS{idVendor}=="05e6", ATTRS{idProduct}=="2450", OWNER="mamba", MODE="0666"
  '';

  # Commented out: NVIDIA GPU support (uncomment and configure if needed)
  # hardware.graphics.enable = true;
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.nvidia.open = true;
  # hardware.nvidia.prime = {
  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };

  # ============================================================
  # VIRTUALISATION
  # ============================================================
  virtualisation.docker.enable = true; # Docker container runtime
  programs.virt-manager.enable = true; # GUI for managing QEMU/KVM VMs
  users.groups.libvirtd.members = ["${username}"]; # Allow user to manage VMs

  # ============================================================
  # SECURITY & POLKIT
  # ============================================================
  security.polkit = {
    enable = true;
    # Allow users in the "users" group to reboot/shutdown without a password
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      })
    '';
  };

  # PAM rule so swaylock can authenticate via the login stack
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # ============================================================
  # SERVICES
  # ============================================================

  # ---- SSH ----
  services.openssh.enable = true;

  # ---- Printing (CUPS) ----
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true; # mDNS hostname resolution for network printers
    openFirewall = true;
  };

  # ---- File Management & Thumbnails ----
  services.gvfs.enable = true; # Virtual filesystem (MTP, SMB, trash, etc.)
  services.tumbler.enable = true; # Thumbnail generator for file managers

  # ---- D-Bus & udev ----
  services.dbus.enable = true;
  services.udev.enable = true;
  services.envfs.enable = true; # Exposes binaries from nix store to /usr/bin etc.

  # ---- Input ----
  services.libinput.enable = true; # Touchpad/pointer input handling

  # ---- GNOME Keyring ----
  services.gnome.gnome-keyring.enable = true; # Secret/credential storage daemon

  # ---- Smart Disk Monitoring ----
  services.smartd = {
    enable = false; # Set true to enable S.M.A.R.T. disk monitoring
    autodetect = true;
  };

  # ---- OneDrive ----
  services.onedrive.enable = true; # Background OneDrive sync daemon

  # ---- PostgreSQL ----
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    dataDir = "/var/lib/postgresql/15";
    # Trust-based auth for local connections (suitable for dev; tighten for production)
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };

  # ---- Flatpak ----
  services.flatpak.enable = false; # Set true to enable Flatpak app support
  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # ---- NFS / RPC (disabled) ----
  services.rpcbind.enable = false;
  services.nfs.server.enable = false;

  # ============================================================
  # MISC PROGRAMS
  # ============================================================
  programs.nix-ld.enable = true; # Run unpatched dynamic binaries (e.g. pre-built ELFs)
}
