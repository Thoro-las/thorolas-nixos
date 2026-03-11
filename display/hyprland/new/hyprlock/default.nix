{ pkgs, config, lib, ... }:

{
  xdg.configFile."hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/new/hyprlock/hyprlock.conf";
  xdg.configFile."hypr/hyprlock/scripts".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/new/hyprlock/scripts";
}
