{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      obs-studio
      droidcam
      android-tools
    ];
  };
}
