{ pkgs, lib, ... }:

let
  javacard-tools = pkgs.stdenv.mkDerivation rec {
    pname = "javacard-tools";
    version = "1.0";

    src = builtins.path {
      path = ./tools/javacard;
      name = "javacard-tools";
    };

    dontBuild = true;
    nativeBuildInputs = [ pkgs.patchelf ];

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/java
      mkdir -p $out/share/javacard-sim

      cp -r $src/JCDK/lib/* $out/share/java/
      cp -r $src/JCSim/runtime/bin $out/share/javacard-sim/
      cp -r $src/JCDK/bin/* $out/bin/

      if [ -f "$out/share/javacard-sim/bin/jcsl" ]; then
        chmod +w $out/share/javacard-sim/bin/jcsl
        ${pkgs.patchelf}/bin/patchelf \
          --set-interpreter ${pkgs.glibc}/lib/ld-linux.so.2 \
          --set-rpath $out/share/javacard-sim/bin \
          $out/share/javacard-sim/bin/jcsl

        ln -s $out/share/javacard-sim/bin/jcsl $out/bin/jcsl
      fi
    '';

    meta = {
      description = "JavaCard Development Kit and Simulator tools";
      license = pkgs.lib.licenses.unfreeRedistributable;
      platforms = pkgs.lib.platforms.linux;
    };
  };
in
{
  module = {
    packages = [
      javacard-tools

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
