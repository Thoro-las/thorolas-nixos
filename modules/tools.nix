{ lib, pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      btop

      fd
      pdfcpu
      vimgolf

      zip
      unzip

      wget
      ripgrep
      trashy
      busybox

      less

      reptyr
      walker
      xournalpp

      android-tools

      zoom-us

      losslesscut
      openshot-qt
      openai-whisper
      (lib.lowPrio subtitleedit)

      xppen_4
      opentabletdriver

      cheese

      yt-dlp
    ];
  };
}
