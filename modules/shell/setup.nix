{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      eza
      zoxide
    ];
  };
}
