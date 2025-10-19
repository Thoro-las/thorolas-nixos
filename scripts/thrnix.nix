{ ... }:

{
  name = "thrnix";
  language = "python";

  aliases = {
    hello = "echo 'hello'";
  };

  script = ''
    print("test")
  '';
}
