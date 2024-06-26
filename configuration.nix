{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./fonts.nix # Include the fonts configuration.
    ./users.nix # Include the users configuration.
    <home-manager/nixos>
  ];

  # Kernel and Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "transparent_hugepage=never" ];
    kernelModules = [ "i2c-dev" "ddcci_backlight" ];
    extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    extraModprobeConfig = ''
      options snd_hda_intel power_save=0
    '';
  };
  hardware.i2c = { enable = true; };

  # Filesystems.
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    #  "/swap".options = [ "noatime" ];
  };
  
  # zramSwap.
  zramSwap.enable = true;
  
  # VAAPI.
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  # Networking.
  networking = {
    hostName = "nixos-on-asus"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # GNOME Desktop.
  # services = {
  #   xserver = {
  #     enable = true;
  #     displayManager.gdm.enable = true;
  #     desktopManager.gnome.enable = true;
  #   };
  #   gnome.gnome-settings-daemon.enable = true;
  # };

  # KDE Plasma Desktop.
  services.displayManager = {
    sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  # Enable DConf and GNOME terminal.
  programs = {
    dconf.enable = true;
    #   gnome-terminal.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Flatpak.
  services.flatpak.enable = true;

  #XDG Portal
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Fcitx5.
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons fcitx5-configtool ];
    fcitx5.waylandFrontend = true;
  };

  # KVM Virt Manager.
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # VirtualBox.
  # virtualisation.virtualbox.host.enable = true;

  # VMWare.
  # virtualisation.vmware.host.enable = true;

  # Podman.
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.containers.enable = true;

  # v2rayA.
  services.v2raya.enable = true;

  # Nexttrace and Traceroute.
  programs.nexttrace.enable = true;
  programs.traceroute.enable = true;

  # Allow unfree packages.
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (pkg: true);
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    nano
    nvtopPackages.full
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-good
    curl
    intel-media-driver
    firefox
    fastfetch
    p7zip
    unzip
    unrar
    ddcutil
    brightnessctl
    libva-utils
    git
    mission-center
    bind
    file
    bat
    vscode
    epiphany
    powershell
    ventoy-full
    xsettingsd
    xorg.xrdb
    vulkan-tools
    nftables
    podman-tui
    glxinfo
    clinfo
    wayland-utils
    dae
    bridge-utils
  ];

  # Environments.
  environment = {
    variables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XMODIFIERS = "@im=fcitx";
      # QT_IM_MODULE = "fcitx";
      # QT_QPA_PLATFORMTHEME = "gnome";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
