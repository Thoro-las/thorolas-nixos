{ pkgs, lib, ... }:

{
  module = {
    packages = [
      pkgs.mdterm
      pkgs.swaks

      pkgs.nodejs
      pkgs.nodemon
      pkgs.tsx
      pkgs.typescript
      pkgs.typescript-language-server

      pkgs.clang
      (lib.lowPrio pkgs.gcc)
      pkgs.clang-tools

      pkgs.gdb
      pkgs.cgdb
      pkgs.gdbgui
      pkgs.valgrind
      pkgs.glibc
      pkgs.glibc.static
      pkgs.glibcInfo
      pkgs.tinycc
      pkgs.gnumake
      pkgs.cmake
      pkgs.eigen
      pkgs.cppman


      (pkgs.lua.withPackages (ps: [ ps.cjson ]))
      pkgs.luajitPackages.jsregexp

      pkgs.jdk
      pkgs.gradle
      (lib.lowPrio pkgs.eclipses.eclipse-dsl)
      (lib.lowPrio pkgs.jdk25_headless)
      (lib.lowPrio pkgs.jdk8_headless)

      pkgs.live-server
      pkgs.processing

      pkgs.arduino
      pkgs.arduino-cli
      pkgs.arduino-language-server

      pkgs.mono
      pkgs.glade
      pkgs.gtk3
      pkgs.glib
      pkgs.SDL2
      pkgs.SDL2_image
      pkgs.dotnet-sdk
      pkgs.netcoredbg
      pkgs.azure-cli
      pkgs.skia

      pkgs.glfw
      pkgs.mesa
      pkgs.libxkbcommon
      pkgs.libX11
      pkgs.libXcursor
      pkgs.libXi
      pkgs.libXrandr
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

      (pkgs.python3.withPackages (
        ps: with ps; [
          ptpython
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

          fastapi
          uvicorn

          cryptography

          scapy
        ]
      ))

      pkgs.uv

      pkgs.geckodriver
      pkgs.chromedriver
      pkgs.selenium-manager
      pkgs.selenium-server-standalone
      (lib.lowPrio pkgs.jupyter)
      (lib.lowPrio pkgs.jupyter-all)

      pkgs.qt6.qtbase
      pkgs.qt6.qtdeclarative
      pkgs.qt6.qttools
      pkgs.qt6.qtwayland
      pkgs.qt6.qtquick3d
      pkgs.qt6.qtquicktimeline

      pkgs.sageWithDoc
      pkgs.nixfmt
      pkgs.quarto

      pkgs.antigravity
      pkgs.wayland-scanner

      pkgs.direnv
    ];

    aliases = {
      m = "make";
    };
  };
}
