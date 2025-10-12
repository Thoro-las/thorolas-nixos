{pkgs}:
{
  home.file.".config/hypr" = {
    source = ./config/hypr;
    recursive = true;
  };

  home.file.".config/swaync" = {
    source = ./config/swaync;
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = ./config/rofi;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./config/waybar;
    recursive = true;
  };

}
