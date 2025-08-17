{ ... }:
{
  module = {
    program = "htop";
    packages = [ "htop-vim" ];
    
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
    nigatron = "the";
    test = 3;
  };
}
