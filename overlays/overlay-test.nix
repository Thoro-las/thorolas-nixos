final: prev: {
  permittedInsecurePackages = [
    "ciscoPacketTracer8-8.2.2"
  ];
  # overlay-test = prev.writeShellScriptBin "overlay-test" ''
  #   echo "Overlay is loaded and working"
  # '';
}
