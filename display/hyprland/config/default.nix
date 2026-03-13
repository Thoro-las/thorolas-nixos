{ config, ... }:
{
  home.file.".config/hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/hypr";
    recursive = true;
  };

  home.file.".config/swaync" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/swaync";
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/rofi";
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/config/waybar";
    recursive = true;
  };
}
