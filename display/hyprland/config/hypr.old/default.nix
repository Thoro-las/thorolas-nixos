{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/hypr.old";
}
