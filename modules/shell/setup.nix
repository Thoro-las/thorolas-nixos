{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.eza
      pkgs.zoxide
      pkgs.tmux
    ];

    aliases = {
      "ls" = "eza --icons --group-directories-first";
    };
  };
}
