{ lib, stdenv, fetchurl, unzip }:

let
  pname = "cursor";
  version = "0.48.2";
  sha = "7d6318dfcfbf7c12a87e33c06978f23167a6de3c";
  
  sources = {
    aarch64-darwin = fetchurl {
      url = "https://downloads.cursor.com/production/${sha}/darwin/arm64/Cursor-darwin-arm64.zip";
      sha256 = "6ba29f61b39084365b3c24367b8e8b1442519b71b3e30329a4635a492dfcc11a";
    };
    x86_64-darwin = fetchurl {
      url = "https://downloads.cursor.com/production/${sha}/darwin/x64/Cursor-darwin-x64.zip";
      sha256 = "426280a045700f1b633749bcf81ddd49e78b64d194e9e5589d28fa1c0ad4ab83";
    };
  };
in

stdenv.mkDerivation {
  inherit pname version;
  
  src = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  
  nativeBuildInputs = [ unzip ];
  
  sourceRoot = ".";
  
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Cursor.app" "$out/Applications/"
    
    # Create bin directory and symlink the binary
    mkdir -p "$out/bin"
    ln -s "$out/Applications/Cursor.app/Contents/Resources/app/bin/code" "$out/bin/cursor"
  '';
  
  meta = with lib; {
    description = "Write, edit, and chat about your code with AI";
    homepage = "https://www.cursor.com/";
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    maintainers = with maintainers; [ ];
    mainProgram = "cursor";
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
} 