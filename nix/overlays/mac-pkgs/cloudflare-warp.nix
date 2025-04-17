{
  lib,
  stdenv,
  fetchurl,
  undmg,
  pkgs,
}:

let
  pname = "cloudflare-warp";
  version = "2025.2.664.0";
  
  src = fetchurl {
    url = "https://downloads.cloudflareclient.com/v1/download/macos/version/${version}";
    sha256 = "sha256-qutpeSxnr2FvaxKEk/k6RsOT8vctLW0GK+XGvUPjvvE="; # aaeb94737c167ba016fb1b4b8a193f3a0ad12d2f72bd5c0b625fabf1383e9bf1
  };

  meta = with lib; {
    description = "Free app that makes your Internet safer";
    homepage = "https://cloudflarewarp.com/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    mainProgram = "cloudflare-warp";
  };

  darwin = stdenv.mkDerivation {
    inherit
      pname
      version
      src
      meta
      ;

    nativeBuildInputs = [ pkgs.installShellFiles ];
    
    unpackPhase = ''
      mkdir -p unpacked
      cp $src unpacked/Cloudflare_WARP_${version}.pkg
    '';

    installPhase = ''
      runHook preInstall
      
      # Create a dummy app to satisfy the derivation
      mkdir -p $out/Applications/Cloudflare\ WARP.app/Contents/MacOS
      mkdir -p $out/Applications/Cloudflare\ WARP.app/Contents/Resources
      
      # Create a shell script that installs the actual package
      cat > $out/Applications/Cloudflare\ WARP.app/Contents/MacOS/Cloudflare-WARP << EOF
      #!/bin/bash
      
      # Check if Cloudflare WARP is already installed
      if [ ! -d "/Applications/Cloudflare WARP.app" ]; then
        # Extract and install the pkg from original location
        echo "Installing Cloudflare WARP..."
        sudo installer -pkg "$out/Applications/Cloudflare WARP.app/Contents/Resources/Cloudflare_WARP_${version}.pkg" -target /
      else
        # Launch the app if already installed
        open "/Applications/Cloudflare WARP.app"
      fi
      EOF
      
      chmod +x $out/Applications/Cloudflare\ WARP.app/Contents/MacOS/Cloudflare-WARP
      
      # Copy the pkg file to the app bundle
      cp unpacked/Cloudflare_WARP_${version}.pkg $out/Applications/Cloudflare\ WARP.app/Contents/Resources/
      
      # Create a simple Info.plist
      cat > $out/Applications/Cloudflare\ WARP.app/Contents/Info.plist << EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>Cloudflare-WARP</string>
        <key>CFBundleIdentifier</key>
        <string>com.cloudflare.1dot1dot1dot1.macos.wrapper</string>
        <key>CFBundleName</key>
        <string>Cloudflare WARP</string>
        <key>CFBundleVersion</key>
        <string>${version}</string>
        <key>CFBundleShortVersionString</key>
        <string>${version}</string>
      </dict>
      </plist>
      EOF
      
      runHook postInstall
    '';
  };
in
darwin 