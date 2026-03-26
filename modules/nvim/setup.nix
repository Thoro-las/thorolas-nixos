{ pkgs, config, lib, ... }:
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

      fsharp
      fsautocomplete

      lua-language-server
      rust-analyzer
      nodePackages.typescript-language-server
      pyright

      stylua
      black
      eslint_d

      tinymist
      typstyle
      vim

      skim
      viu
      gzip
      hpx

      tree-sitter

      jdt-language-server


      imagemagick
      chafa
      ueberzug
      (lib.lowPrio ueberzugpp)
      pkg-config
      imagemagick
      imagemagick.dev

      julia

      fzf

      figlet
      pandoc
      glow

      luaPackages.jsregexp
    ];

    sources = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/nvim/config";
        recursive = true;
      };
    };
  };

  config = {
    enable = true;
    defaultEditor = true;
  };
}
