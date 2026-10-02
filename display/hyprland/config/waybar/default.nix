{
  pkgs,
  config,
  lib,
  ...
}:

{
  home.file.".config/waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/waybar";
}
