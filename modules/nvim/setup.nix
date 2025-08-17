{ pkgs, ... }:
{
  module = {
    program = "neovim";
    packages = with pkgs; [
      luarocks-nix
      mercurial
      ripgrep
      trashy
      nodejs
      cargo
      ruby
      php
      go
    ];

    sources = {
      ".config/nvim" = {
        source = ./config;
        recursive = true;
      };
    };
  };

  config = {
    enable = true;
    defaultEditor = true;
  };
}
