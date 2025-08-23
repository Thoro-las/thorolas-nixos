{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      steam
    ];
  };
}
