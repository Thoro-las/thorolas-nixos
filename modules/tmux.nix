{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "tmux";
  };

  config = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";

    mouse = false;
    escapeTime = 0;
    keyMode = "vi";

    extraConfig = ''
      unbind h
      unbind v

      bind h split-window -h
      bind v split-window -v

      bind -n c-h select-pane -L
      bind -n c-l select-pane -R
      bind -n c-k select-pane -U
      bind -n c-j select-pane -D

      # Visual settings
      set -g visual-activity off
      set -gq allow-passthrough on
      set -g base-index 1
      setw -g pane-base-index 1

      # Status bar styling
      set-option -g status-style "bg=default,fg=white"
      set-option -g status-left-length 30
      set-option -g status-right-length 50
      set-option -g window-status-separator \'\'
      set-option -g message-style "bg=red,fg=black"
      set -g pane-border-style "fg=black"
      set -g pane-active-border-style "bg=default fg=blue"

      # Status bar content
      set-option -g status-left " #{?client_prefix,#[fg=violet],#[fg=blue]}󰈈 #{?client_prefix,Prefix,Normal}"
      set-option -g status-right "#[fg=blue] #[fg=green]%H:%M #[fg=blue]~ #[fg=yellow]%d %A %B %Y "

      # Window status format
      set-option -g window-status-current-format " #[fg=yellow]#I#[fg=default]:#[fg=green]#W"
      set-option -g window-status-format " #[fg=default]#I:#W"
    '';
  };
}
