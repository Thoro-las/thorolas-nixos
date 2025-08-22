{ pkgs, ... }:
{
  module = {
    program = "kitty";
    packages = with pkgs; [
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
