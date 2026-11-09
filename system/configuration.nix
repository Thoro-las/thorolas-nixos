{ pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;

  services.xserver.desktopManager.gnome.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.resolved.enable = true;
  services.resolved.fallbackDns = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  networking.firewall.allowedTCPPorts = [ 4747 ];
  networking.firewall.allowedUDPPorts = [ 4747 ];

  networking = {
    hostName = "thorolas";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      insertNameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };

    nat = {
      enable = true;
      externalInterface = "enp0s31f6";
      internalInterfaces = [ "wlan0" ];
    };

    extraHosts = ''
      104.21.9.215 ping.usebottles.com
    '';

    firewall.enable = true;
    firewall.trustedInterfaces = [ "wlan0" ];
  };

  services.vsftpd.enable = true;
  services.sshd.enable = true;

  system.nssModules = lib.mkForce [ ];

  time.timeZone = "Africa/Algiers";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # hardware.opentabletdriver.enable = true;
  # hardware.uinput.enable = true;
  # boot.kernelModules = [ "uinput" ];

  console.keyMap = "be-latin1";
  services.xserver.xkb = {
    layout = "be";
    variant = "nodeadkeys";
  };

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "vinyl";
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    polkit
    dconf
    bluez
    libnotify

    wlogout
    nautilus
    rofi
    rofi-bluetooth
    rofi-network-manager
    networkmanager_dmenu
    pavucontrol

    waybar
    hyprpaper
    hypridle
    hyprlock
    hyprshot
    nwg-drawer
    swaynotificationcenter
    blueman
    brightnessctl
    fastfetch
  ];

  services.displayManager.defaultSession = "hyprland-uwsm";

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.gamemode.enable = true;

  programs.nix-ld.enable = true;
  programs.xwayland.enable = true;
  programs.steam.enable = true;
  programs.wireshark.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  fonts.packages = with pkgs; [
    udev-gothic-nf
    noto-fonts
    liberation_ttf
  ];

  services.flatpak.enable = true;
  services.printing.enable = true;
  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  boot = {
    plymouth = {
      enable = true;
      theme = "circuit";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "circuit" ];
        })
      ];
    };

    initrd.systemd.enable = true;
    initrd.kernelModules = [ "i915" ];

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "video=1920x1080"
    ];

    blacklistedKernelModules = [
      "kvm"
      "kvm_intel"
      "kvm_amd"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
    "pipe-operators"
  ];

  system.stateVersion = "26.05";



# Include the v4l2loopback kernel module package matching your active kernel
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  # Load the module automatically at boot
  boot.kernelModules = [
    "v4l2loopback"
  ];

  # (Optional) Pass options to v4l2loopback to create named virtual devices
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="DroidCam" exclusive_caps=1
  '';
}
