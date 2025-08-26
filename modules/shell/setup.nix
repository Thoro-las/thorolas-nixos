{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.eza
      pkgs.zoxide
      pkgs.tmux
    ];

    aliases = {
      ls = "eza --icons=always --group-directories-first";
      fishr = "source $HOME/.config/fish/config.fish";
    };
  };
}
