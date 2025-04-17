{ lib, stdenv, unzip, fetchurl }:

let
  pname = "cursor";
  version = "0.48.9";
  sha = "61e99179e4080fecf9d8b92c6e2e3e00fbfb53f4";
  
  sources = {
    aarch64-darwin = fetchurl {
      url = "https://downloads.cursor.com/production/${sha}/darwin/arm64/Cursor-darwin-arm64.zip";
      sha256 = "sha256-NkOQkosWDmQe03hgVf8yqQOuWflvoKkUU97V2d8Dbc0=";
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