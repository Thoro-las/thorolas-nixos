{ pkgs, lib, ... }:

{
  module = {
    sources = {
      ".libraries" = {
        source = ./libraries;
        recursive = true;
      };

      ".local/share/jupyter/kernels/sagemath/kernel.json".source =
        pkgs.writeText "sage-kernel.json" ''
          {
            "argv": [
              "${pkgs.sageWithDoc}/bin/sage",
              "--python",
              "-m",
              "sage.repl.ipython_kernel",
              "-f",
              "{connection_file}"
            ],
            "display_name": "SageMath ${pkgs.sageWithDoc.version}",
            "language": "sage",
            "codemirror_mode": "python"
          }
        '';
    };

    packages = [
      (pkgs.python3.withPackages (ps:
        with ps; [
          pip

          ipython
          ipykernel
          jupyter-client
          jupyter-console
          jupyter
          jupytext
          nbformat
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
        ]))

      (lib.lowPrio pkgs.jupyter)
      pkgs.selenium-manager
      pkgs.geckodriver
      pkgs.qt6.qttools

      pkgs.sageWithDoc

      pkgs.ueberzug
      pkgs.pkg-config
      pkgs.imagemagick
      pkgs.imagemagick.dev

      pkgs.nodejs

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
      # pkgs.maven
      pkgs.gradle
      # pkgs.jdt-language-server
      # pkgs.jetbrains.idea-community
      # pkgs.eclipses.eclipse-java

      pkgs.live-server
      pkgs.processing
      pkgs.arduino

      pkgs.mono
      pkgs.dotnet-sdk
      pkgs.glade
      pkgs.gtk3
      pkgs.glib
      pkgs.SDL2
      pkgs.SDL2_image

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

      pkgs.clojure
      pkgs.clojure-lsp

      pkgs.nim
      pkgs.nim_lk
      pkgs.nim_builder
      pkgs.nimlsp
      pkgs.nimble
    ];
  };

}
