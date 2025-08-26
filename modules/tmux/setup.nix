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

    # prefix = "C-x";

    extraConfig = ''
      # Send prefix key through
      # bind-key C-x send-prefix
      
      # Visual settings
      set -g visual-activity off
      set -gq allow-passthrough on
      
      # Unbind default keys
      unbind %
      unbind \"
      unbind n
      unbind p
      unbind C-z
      
      # Key bindings
      # bind r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf Reloaded"
      # bind | split-pane -h -c "#{pane_current_path}"
      # bind _ split-pane -v -c "#{pane_current_path}"
      # bind c next-window
      # bind z previous-window
      # bind a new-window -c "#{pane_current_path}"
      # bind p choose-buffer
      # bind Up select-pane -U
      # bind Down select-pane -D
      # bind Left select-pane -L
      # bind Right select-pane -R
      # 
      # # Copy mode bindings
      # bind-key -T copy-mode C-Right send-keys -X next-word
      # bind-key -T copy-mode C-Left send-keys -X previous-word
      
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
      set-option -g status-right "#[fg=green] %H:%M #[fg=yellow]󪰀 %d %A %B %Y"

      # Window status format
      set-option -g window-status-current-format " #[fg=yellow]#I#[fg=default]:#[fg=green]#W"
      set-option -g window-status-format " #[fg=default]#I:#W"
    '';
  };
}
