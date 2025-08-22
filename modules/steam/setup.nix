{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      steam
    ];
  };

  config = {
    enable = true;
  };
}
