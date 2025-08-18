{ ... }:

{
  name = "thrnix";
  language = "bash";

  script = ''
    echo "hello man"
    for arg in "$@"
    do
      echo "[$arg]"
    done
  '';
}
