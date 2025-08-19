{
  check-script = script-file:
    if !((script-file ? name) || (script-file ? script))
      then builtins.throw "name or script attribute missing in ${script-file}"
      else script-file;
}
