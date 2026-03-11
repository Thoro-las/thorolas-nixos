{ ... }@args:
{
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  home.file.".config/swaync" = {
    source = ./swaync;
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = ./rofi;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
