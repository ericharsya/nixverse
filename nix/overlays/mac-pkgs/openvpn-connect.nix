{ lib, stdenv, fetchurl, undmg }:

let
  pname = "openvpn-connect";
  version = "3.7.0";
  build = "5510";
  fullVersion = "${version},${build}";

  underscoreVersion = builtins.replaceStrings ["."] ["_"] version;
  archType = if stdenv.hostPlatform.system == "aarch64-darwin" then "arm64" else "x86_64";
  
  src = fetchurl {
    url = "https://swupdate.openvpn.net/downloads/connect/openvpn-connect-${version}.${build}_signed.dmg";
    sha256 = "afd99e6474558c11077c18e513f5338b2dfea7f62eda9031d43518648289fb4f";
  };
  
  installerName = "OpenVPN_Connect_${underscoreVersion}(${build})_${archType}_Installer_signed.pkg";
in

stdenv.mkDerivation {
  inherit pname version src;
  
  nativeBuildInputs = [ undmg ];
  
  sourceRoot = ".";
  
  installPhase = ''
    mkdir -p $out/Applications
    
    # Create a directory to store the installer
    mkdir -p $out/share/openvpn-connect
    cp "${installerName}" $out/share/openvpn-connect/
    
    # Create a script to run the installer
    mkdir -p $out/bin
    cat > $out/bin/openvpn-connect-installer <<EOF
    #!/bin/sh
    open $out/share/openvpn-connect/${installerName}
    EOF
    chmod +x $out/bin/openvpn-connect-installer
  '';
  
  meta = with lib; {
    description = "Client program for the OpenVPN Access Server";
    homepage = "https://openvpn.net/client-connect-vpn-for-mac-os/";
    license = licenses.unfree;
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    maintainers = with maintainers; [ ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
} 