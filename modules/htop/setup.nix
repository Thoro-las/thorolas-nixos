{ pkgs, ... }:
{
  module = {
    program = "htop";
    packages = [ ];
    
    aliases = { 
      htp = "htop";
      h = "htop";
    };

    sources = {
      thing = "/home/thing/test";
      thing2 = "/home/thing2/";
    };
  };

  config = {
    enable = true;
    settings.color_scheme = 3;
  };
}
