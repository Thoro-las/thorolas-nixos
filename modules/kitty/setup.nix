{ pkgs, ... }:
{
  module = {
    program = "kitty";
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    sources = {
      ".config/kitty" = {
        source = ./config;
        recursive = true;
      };
    };
  };

  config = {
    enable = true;
  };
}
