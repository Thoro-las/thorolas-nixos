
{ pkgs, ... }:

{
  name = "thrprojector";
  language = "python";

  packages = [
    pkgs.gum
  ];

  script = ''
    echo "Hello World!"
  '';
}
