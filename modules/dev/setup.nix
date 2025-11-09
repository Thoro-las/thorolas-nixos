{ pkgs, lib, ... }:

{
  module = {
    packages = [

      (pkgs.python3.withPackages (ps: with ps; [ 
        pip

        ipython
        jupyter 
        jupytext
        jupyter_client
        jupyter_core
        jupyter-client
        jupyter-core
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
      ]))

      pkgs.pkg-config
      pkgs.imagemagick
      pkgs.imagemagick.dev

      pkgs.nodejs

      pkgs.logisim-evolution

      pkgs.gcc
      pkgs.tinycc
      pkgs.lua5_1
      pkgs.gnumake

      pkgs.jdk
      pkgs.openjfx
      pkgs.jdt-language-server
      pkgs.jetbrains.idea-community
      pkgs.eclipses.eclipse-java
      pkgs.spring-boot-cli
      pkgs.scenebuilder
      pkgs.gradle

      pkgs.dotnet-sdk
      pkgs.SDL2
      pkgs.SDL2_image

      pkgs.vscode
    ];
  };
}
