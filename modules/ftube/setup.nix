{ ... }:

{
  module = {
    package = "freetube";
    dependencies = [ "first_dep" "second_dep" ];
    
    aliases = { 
      ftube = "freetube";
      ft = "freetube";
    };

    sources = {
      thing = "/home/thing/test";
      thing2 = "/home/thing2/";
    };
  };

  config = {
    test = "value";
  };
}
