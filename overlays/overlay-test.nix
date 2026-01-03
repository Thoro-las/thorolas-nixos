final: prev: {
  overlay-test = prev.writeShellScriptBin "overlay-test" ''
    echo "Overlay is loaded and working"
  '';
}
