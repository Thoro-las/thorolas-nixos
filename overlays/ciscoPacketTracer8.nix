self: super: {
  ciscoPacketTracer8 = super.ciscoPacketTracer8.overrideAttrs (old: rec {
    # Wrap the original packettracer binary
    installPhase = ''
      ${old.installPhase}
      mkdir -p $out/bin
      cat > $out/bin/packettracer <<EOF
#!/usr/bin/env bash
# Force IPv4 (fix SSL / login hangs)
export QT_NETWORK_IPV6=0

# Set Qt WebEngine paths so network subprocess can find resources
PT_PATH=${old.prefix}/opt/pt/bin
export QTWEBENGINEPROCESS_PATH=\$PT_PATH
export QTWEBENGINE_RESOURCES_PATH=\$PT_PATH/resources

# Make sure libraries are visible to subprocess
export LD_LIBRARY_PATH=\$PT_PATH:\$LD_LIBRARY_PATH

# Launch the real Packet Tracer
exec \$PT_PATH/packettracer "\$@"
EOF
      chmod +x $out/bin/packettracer
    '';
  });
}
