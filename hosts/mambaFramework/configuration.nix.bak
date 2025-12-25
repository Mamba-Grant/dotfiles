# 💫 https://github.com/JaKooLit 💫 #
# Main default config
# NOTE!!! : Packages and Fonts are configured in packages-&-fonts.nix
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
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/amd-drivers.nix
    # ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
  ];
  programs.xfconf.enable = true;

  # set my own local nvim/nvf config as a system package
  # environment.systemPackages = [inputs.nvf.defaultPackage.x86_64-linux];
  programs.nix-ld.enable = true;
  virtualisation.docker.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15; # or another version like postgresql_14
    dataDir = "/var/lib/postgresql/15"; # Change version to match above
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };

  fileSystems."/mnt/ZHOU_GRP" = {
    device = "g293s490@zhou1.physics.ku.edu:/mnt/g293s490/ZHOU_GRP";
    fsType = "sshfs";
    options = [
      "nodev"
      "noatime"
      "allow_other"
      "IdentityFile=/root/.ssh/id_ed25519"
      "uid=1000"
      "gid=100"
    ];
  };

  # BOOT related stuff
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Kernel

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
    ];

    # This is for OBS Virtual Cam Support
    kernelModules = ["v4l2loopback" "usbtmc"];
    #  extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };

    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;

    loader.efi = {
      canTouchEfiVariables = true;
    };

    loader.timeout = 5;

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth.enable = true;
  };

  # Extra Module Options
  drivers.amdgpu.enable = true;
  drivers.intel.enable = true;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  networking.networkmanager.wifi.powersave = true;
  systemd.services."NetworkManager-wait-online".enable = false; # make network go after startup to save 5-6 seconds

  # Set your time zone.
  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "America/Chicago"; # Central Time Zone

  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    #pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    openssh.enable = true;
    flatpak.enable = false;

    blueman.enable = true;

    fwupd.enable = true;

    upower.enable = true;

    gnome.gnome-keyring.enable = true;

    printing = {
      enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
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
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      trusted-users = ["root" "mamba"];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["${username}"];
  users.groups.usbtmc = {};

  # Add udev rules for NI-VISA USB Raw devices (proper NI-VISA format)
  services.udev.extraRules = ''
    # Keithley 2450 permissions
    SUBSYSTEM=="usb", ATTRS{idVendor}=="05e6", ATTRS{idProduct}=="2450", MODE="0666", GROUP="usbtmc", SYMLINK+="keithley2450"

    # Generic USBTMC support
    SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="fe", ATTR{bInterfaceSubClass}=="03", MODE="0666", GROUP="usbtmc"

    # Optional: give user access
    SUBSYSTEM=="usb", ATTRS{idVendor}=="05e6", ATTRS{idProduct}=="2450", OWNER="mamba", MODE="0666"
  '';

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          })
          .fd
        ];
      };
    };
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = true;
  hardware.nvidia.prime = {
    # offload = {
    #   enable = lib.mkOverride 990 true;
    #   enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
    # };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
