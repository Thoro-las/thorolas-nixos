{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thorolas";
  networking.networkmanager.enable = true;

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

  console.keyMap = "be-latin1";
  services.xserver.xkb = {
    layout = "be";
    variant = "nodeadkeys";
  };

  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    lunarvim
    tmux
    wget
    git

    neovim
    mercurial
    lua5_1
    luarocks-nix
    nodejs
    go
    cargo
    ruby
    php
    ripgrep
    trashy

    zathura
    vimiv-qt
    yazi
    kitty
    discord

    gnumake
    dotnet-sdk
    python3
    gcc

    eww
    rofi
    dmenu
    notify
    libnotify
    feh

    xclip

    appimage-run
    unetbootin

    inkscape
    krita
    steam
  ];

  boot = {
    plymouth = {
      enable = true;
      theme = "circuit";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override { selected_themes = [ "circuit" ]; })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    # loader.timeout = 0;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
