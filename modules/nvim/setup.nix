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

      lua-language-server
      rust-analyzer
      nodePackages.typescript-language-server
      pyright

      stylua
      black
      # prettier
      eslint_d

      tinymist
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
