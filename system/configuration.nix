{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.useHostResolvConf = false;

  # networking = {
  #   useDHCP = false;
  #   hostName = "thorolas";
  #
  #   interfaces.wlan0.ipv4.addresses = [{
  #     address = "192.168.50.1";
  #     prefixLength = 24;
  #   }];
  #
  #   nat = {
  #     enable = true;
  #     externalInterface = "eth0";
  #     internalInterfaces = [ "wlan0" ];
  #   };
  # };

  # services.dnsmasq = {
  #   enable = true;
  #   settings = {
  #     interface = "wlan0";
  #     dhcp-range = "192.168.50.10,192.168.50.100,12h";
  #   };
  # };

  networking.firewall.enable = true;

  services.resolved.enable = true;
  services.resolved.dnssec = "allow-downgrade";
  services.resolved.fallbackDns = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ];

  services.nscd.enable = false;

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

    wlogout
    kdePackages.dolphin
    rofi-wayland
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
    neofetch
  ];

  services.displayManager.defaultSession = "hyprland-uwsm";

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  programs.nix-ld.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.xwayland.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

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
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "circuit" ];
          })
        ];
    };

    uvesafb.enable = true;
    initrd.systemd.enable = true;

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    blacklistedKernelModules = [ "kvm" "kvm_intel" "kvm_amd" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
