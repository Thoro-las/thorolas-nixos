{ pkgs, config, ... }:
{
  module = {
    program = "kitty";
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    sources = {
      ".config/kitty" = {
        # source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/kitty/config/";
        source = ./config;
        recursive = true;
      };
    };
  };
}
