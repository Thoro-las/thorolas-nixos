{ config, lib, ... }:




{ 
  xdg.configFile."rofi".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/display/hyprland/new/programs/rofi";
}
