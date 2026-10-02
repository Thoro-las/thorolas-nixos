{
  pkgs,
  config,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  home.file.".config/swaync".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/swaync";
}
