{ ... }:

{
  module = {
    package = "freetube";
    dependencies = [];
    
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
  };
}
