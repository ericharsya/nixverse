{ lib, stdenv, fetchurl, unzip, undmg, pkgs }:

let
  pname = "pritunl";
  version = "1.3.4210.52";
  
  src = fetchurl {
    url = "https://github.com/pritunl/pritunl-client-electron/releases/download/${version}/Pritunl.pkg.zip";
    sha256 = "935a00bb88e34dbf1768ef12e4553268352fd86fedd7eec18a3b19701287d99b";
  };
  
  archSuffix = if stdenv.hostPlatform.system == "aarch64-darwin" then "arm64" else "x64";
in

stdenv.mkDerivation {
  inherit pname version src;
  
  nativeBuildInputs = [ unzip pkgs.darwin.xar pkgs.darwin.cpio ];
  
  sourceRoot = ".";
  
  unpackPhase = ''
    unzip $src
    xar -xf Pritunl${archSuffix}.pkg
  '';
  
  installPhase = ''
    mkdir -p $out/Applications
    
    # Extract the payload from the package
    cat Payload | gunzip -dc | cpio -i
    
    # Copy the extracted app to the output
    cp -r Pritunl.app $out/Applications/
  '';
  
  meta = with lib; {
    description = "OpenVPN client";
    homepage = "https://client.pritunl.com/";
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    maintainers = with maintainers; [ ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
} 