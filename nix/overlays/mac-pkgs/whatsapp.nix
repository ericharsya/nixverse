{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:

let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";

  pname = "whatsapp";
  version = "2.25.10.72";
  
  sha256 = "sha256-tTgnJGlN9dIYWWe1MqmSVnQI/fEQeHmwb6+bkp9+/YA="; # 396cd3ab43dec85b105dbc83ca623c7a26490af261acf7183664330b2f25b428

  url = "https://web.whatsapp.com/desktop/mac_native/release/?version=${version}&extension=zip&configuration=Release&branch=relbranch";
  
  src = fetchurl {
    url = url;
    inherit sha256;
  };

  meta = with lib; {
    description = "Native desktop client for WhatsApp";
    homepage = "https://www.whatsapp.com/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    mainProgram = "whatsapp";
  };

  darwin = stdenv.mkDerivation {
    inherit
      pname
      version
      src
      meta
      ;

    nativeBuildInputs = [ unzip ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/Applications
      cp -R WhatsApp.app $out/Applications/
      runHook postInstall
    '';
  };
in
darwin 