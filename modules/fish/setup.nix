{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "fish";
  };

  config = {
    enable = true;

    # Functions
    functions = {
      conf = ''
        set -l files ""
        for path in ~/.config/*
          set files "$files:$path"
        end
        set -l file (string split ":" $files | fzf)
        if test "$file " != " "
          $EDITOR $file
        end
      '';

      fish_prompt = ''
        set -l last_status $status
        printf "\n"
        printf "â"[$(set_color green)$USER$(set_color normal)@$(set_color blue)$hostname$(set_color normal)] "
        set -l cur_dir (pwd)
        if test "" != "$(string match -r "^$HOME" $cur_dir)"
          set cur_dir (string replace -r "^$HOME" "$(set_color red)Home" $cur_dir)
          set cur_dir (string replace -r "/" "$(set_color normal)::$(set_color cyan)" $cur_dir)
        else
          set cur_dir (string replace -r "^/" "$(set_color red)Root$(set_color normal)::" $cur_dir)
          set cur_dir (string replace -r '::$' "" $cur_dir)
          set cur_dir (string replace -r '::' "::$(set_color cyan)" $cur_dir)
        end

        set cur_dir (string replace -ra "/" "$(set_color normal)->$(set_color cyan)" $cur_dir)
        printf "$cur_dir$(set_color normal)"

        set -l git (fish_git_prompt)
        if test "" != "$git"
          set git (string replace -r '^\s*\((.*)\)\s*$' '$1' $git)
          printf " $(set_color purple)🮤$(set_color green)$git$(set_color purple)🮥"
        end
        set -l error_code ""
        if test $last_status -ne 0
          set error_code "$(set_color normal)<$(set_color red)$last_status$(set_color normal)>"
        end
        set -l end_sign "!"
        if test "$USER" = "root"
          set end_sign "#"
        end
        printf "$(set_color normal)\nâ""$(set_color cyan)fish$error_code$(set_color blue)$end_sign$(set_color normal) "
      '';

      fish_greeting = "";
    };

    # Shell aliases
    shellAliases = {
      fishr = "source $HOME/.config/fish/config.fish";
      ls = "exa --icons=always";
    };

    # Interactive shell initialization (for exports and other setup)
    interactiveShellInit = ''
      # Export environment variables
      set -gx EDITOR "nvim"
      set -gx SHELL (which fish)
      
      # Add to PATH
      fish_add_path $HOME/.config/composer/vendor/bin
      fish_add_path $HOME/.local/bin
      fish_add_path $HOME/.luarocks/bin
      
      # Wine configuration
      set -gx WINE_ROOT "$HOME/.wine"
      set -gx WINE_HOME "$WINE_ROOT/drive_c/users/$USER"
    '';

    # Fish universal variables (from your fish_variables file)
    # These will be set when Fish starts
    shellInit = ''
      # Fish color scheme
      set -U fish_color_autosuggestion brblack
      set -U fish_color_cancel -r
      set -U fish_color_command blue
      set -U fish_color_comment red
      set -U fish_color_cwd green
      set -U fish_color_cwd_root red
      set -U fish_color_end green
      set -U fish_color_error brred
      set -U fish_color_escape brcyan
      set -U fish_color_history_current --bold
      set -U fish_color_host normal
      set -U fish_color_host_remote yellow
      set -U fish_color_normal normal
      set -U fish_color_operator brcyan
      set -U fish_color_param cyan
      set -U fish_color_quote yellow
      set -U fish_color_redirection "cyan" "--bold"
      set -U fish_color_search_match "bryellow" "--background=brblack"
      set -U fish_color_selection "white" "--bold" "--background=brblack"
      set -U fish_color_status red
      set -U fish_color_user brgreen
      set -U fish_color_valid_path --underline
      set -U fish_key_bindings fish_default_key_bindings
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description "yellow" "-i"
      set -U fish_pager_color_prefix "normal" "--bold" "--underline"
      set -U fish_pager_color_progress "brwhite" "--background=cyan"
      set -U fish_pager_color_selected_background -r
    '';
  };
}
