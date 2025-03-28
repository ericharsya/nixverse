{
  lib,
  stdenv,
  fetchurl,
  xar,
  cpio,
  makeWrapper,
}:

let
  pname = "openvpn-connect";
  version = "3.7.0";
  build = "5510";
  
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
  
  nativeBuildInputs = [ xar cpio makeWrapper ];
  
  sourceRoot = ".";
  
  unpackPhase = ''
    # Extract the dmg first
    mkdir dmg
    cd dmg
    cp $src ./openvpn-connect.dmg
    $SHELL -c "dd if=openvpn-connect.dmg bs=1 skip=82 | hdiutil attach -nobrowse -noautoopen -mountpoint ./mnt -"
    
    # Extract the pkg contents
    cd mnt
    xar -xf "${installerName}"
    zcat < OpenVPN_Connect.pkg/Payload | cpio -i
  '';
  
  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/Applications
    cp -R ./Applications/OpenVPN\ Connect.app $out/Applications/
    
    mkdir -p $out/bin
    makeWrapper "$out/Applications/OpenVPN Connect.app/Contents/MacOS/OpenVPN Connect" \
      $out/bin/openvpn-connect
    
    runHook postInstall
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