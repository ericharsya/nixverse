{ lib, stdenv, fetchurl, undmg }:

let
  pname = "jetbrains-toolbox";
  version = "2.5.4";
  build = "2.5.4.38621";
  
  sources = {
    aarch64-darwin = fetchurl {
      url = "https://download.jetbrains.com/toolbox/jetbrains-toolbox-${build}-arm64.dmg";
      sha256 = "f418f9a6e1bd3541cee77a17051941e43bd7f631939ab90382357640f1fdaa0d";
    };
    x86_64-darwin = fetchurl {
      url = "https://download.jetbrains.com/toolbox/jetbrains-toolbox-${build}.dmg";
      sha256 = "cb4cd7404a98e658ff7b8e34751b7205f6b0f02c2aaa0ccedd48eb79bdfb67f2";
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
    cp -r "JetBrains Toolbox.app" "$out/Applications/"
  '';
  
  meta = with lib; {
    description = "JetBrains tools manager";
    homepage = "https://www.jetbrains.com/toolbox-app/";
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    maintainers = with maintainers; [ ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
} 