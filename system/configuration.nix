{ pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;

  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.resolved.enable = true;
  services.resolved.fallbackDns = [ "1.1.1.1" "8.8.8.8" ];

  networking = {
    hostName = "thorolas";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
    };

    nat = {
      enable = true;
      externalInterface = "enp0s31f6";
      internalInterfaces = [ "wlan0" ];
    };

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
    kdePackages.dolphin
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
    neofetch

    # TODO: CLEAN LATER
    wget 
    taskwarrior3
    git
    btop
    neovim
    python311
    ffmpeg
    python314
    adw-gtk3
    (wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) {})
    telegram-desktop
    libreoffice-qt
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US
    obsidian
    obs-studio
    p7zip
    papers
    fastfetch
    quickshell
    gnome-shell-extensions
    grim
    playerctl
    satty
    yq-go
    xdg-desktop-portal-gtk
    eww
    swappy
    slurp
    mpvpaper
    gnome-tweaks
    pkgsCross.mingwW64.stdenv.cc
    wmctrl
    bottles
    qbittorrent
    power-profiles-daemon
    jdk8
    steam-run
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
  programs.adb.enable = true;
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

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  system.stateVersion = "25.05";
}
