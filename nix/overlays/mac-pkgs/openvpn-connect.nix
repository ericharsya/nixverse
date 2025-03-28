{ lib, stdenv, fetchurl, undmg }:

let
  pname = "openvpn-connect";
  version = "3.7.0,5510";
  
  sources = {
    aarch64-darwin = fetchurl {
      url = "https://swupdate.openvpn.net/downloads/connect/openvpn-connect-3.7.0.5510_signed.dmg";
      sha256 = "afd99e6474558c11077c18e513f5338b2dfea7f62eda9031d43518648289fb4f";
    };
    x86_64-darwin = fetchurl {
      url = "https://swupdate.openvpn.net/downloads/connect/openvpn-connect-3.7.0.5510_signed.dmg";
      sha256 = "afd99e6474558c11077c18e513f5338b2dfea7f62eda9031d43518648289fb4f";
    };
  };
in

stdenv.mkDerivation {
  inherit pname version;
  
  src = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  
  nativeBuildInputs = [ undmg ];
  
  sourceRoot = ".";
  
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "OpenVPN Connect.app" "$out/Applications/"
  '';
  
  meta = with lib; {
    description = "Client program for the OpenVPN Access Server";
    homepage = "https://openvpn.net/client-connect-vpn-for-mac-os/";
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    maintainers = with maintainers; [ ];
    mainProgram = "openvpn-connect";
  };
} 