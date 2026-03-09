{ pkgs, lib, ... }:

{
  module = {

    packages = [
      pkgs.ueberzug
      pkgs.pkg-config
      pkgs.imagemagick
      pkgs.imagemagick.dev

      pkgs.nodejs
      pkgs.nodemon
      pkgs.tsx
      pkgs.typescript
      pkgs.typescript-language-server

      pkgs.gcc
      pkgs.gdb
      pkgs.glibc
      pkgs.glibc.static
      pkgs.glibcInfo
      pkgs.tinycc
      pkgs.lua5_1
      pkgs.gnumake
      (lib.lowPrio pkgs.clang-tools)

      pkgs.jdk
      pkgs.gradle

      pkgs.live-server
      pkgs.processing
      pkgs.arduino

      pkgs.mono
      pkgs.glade
      pkgs.gtk3
      pkgs.glib
      pkgs.SDL2
      pkgs.SDL2_image
      pkgs.dotnet-sdk
      pkgs.netcoredbg
      pkgs.skia

      pkgs.glfw
      pkgs.mesa
      pkgs.libxkbcommon
      pkgs.xorg.libX11
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.xorg.libXrandr
      pkgs.libGL

      pkgs.vscode

      pkgs.docker
      pkgs.watchexec

      pkgs.qemu
      pkgs.nasm
      pkgs.cdrkit
      pkgs.bochs

      pkgs.dosbox-x
      pkgs.vice
      pkgs.simh

      pkgs.zellij
      pkgs.multitail

      pkgs.clojure
      pkgs.clojure-lsp

      pkgs.nim
      pkgs.nim_lk
      pkgs.nim_builder
      pkgs.nimlsp
      pkgs.nimble

      pkgs.tlaps
      pkgs.tlaplus
      pkgs.tlafmt
      pkgs.tlaplus-toolbox

      (pkgs.python3.withPackages (ps:
        with ps; [
          pip

          ipython
          ipykernel
          jupyter-client
          jupyter-console
          jupyter
          jupytext
          jupynium
          jupyter-themes
          nbformat
          nbclassic
          nbconvert
          notebook
          pynvim
          pillow
          cairosvg
          pnglatex
          plotly
          kaleido
          pyperclip

          numpy
          pandas
          matplotlib

          pyside6
          qtpy
          # (opencv4.override ({ enableGtk3 = true; }))

          cryptography
        ]))

      (lib.lowPrio pkgs.jupyter)
      (lib.lowPrio pkgs.jupyter-all)
      pkgs.selenium-manager
      pkgs.selenium-server-standalone
      pkgs.geckodriver
      pkgs.chromedriver

      pkgs.qt6.qtbase
      pkgs.qt6.qtdeclarative
      pkgs.qt6.qttools
      pkgs.qt6.qtwayland
      pkgs.qt6.qtquick3d
      pkgs.qt6.qtquicktimeline

      pkgs.sageWithDoc

    ];

    sources = {
      ".libraries" = {
        source = ./libraries;
        recursive = true;
      };
    };
  };
}
