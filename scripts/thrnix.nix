{ ... }:

{
  name = "thrnix";
  language = "python";

  script = /*bash*/ ''
  import argparse

  parser = argparse.ArgumentParser(description="Example argument parser")
  parser.add_argument("positional_arg", help="A positional argument")
  parser.add_argument("-o", "--optional", help="An optional argument")

  args = parser.parse_args()
  print("Positional argument:", args.positional_arg)
  if args.optional:
      print("Optional argument:", args.optional)
  '';
}
