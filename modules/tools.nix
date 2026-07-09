{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
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
    ];
  };
}
