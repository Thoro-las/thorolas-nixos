{
  check-script = script-file:
    if !(script-file ? name or script-file ? script)
      then builtins.error "name or script attribute missing in ${script-file}"
      else script-file;
}
