{
  check-script = script-contents:
    if !(script-contents ? name) || !(script-contents ? script)
      then builtins.throw "name or script attribute missing in scripts/${script-contents.name}"
      else script-contents;
}
