{ config, lib, ... }:

{
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/rofi";
}
