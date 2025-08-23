{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      eza
      zoxide
    ];

    aliases = {
      "ls" = "eza --icons --group-directories-first";
    };
  };
}
