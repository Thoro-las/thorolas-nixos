{ pkgs, ... }:
{
  module = {
    program = "sagemath";
  };

  config = {
    enable = true;
  };
}
