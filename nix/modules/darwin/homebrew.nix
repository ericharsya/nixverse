{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in
{
  environment.shellInit =
    mkIf brewEnabled # bash
      ''
        eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
      '';

  system.activationScripts.preUserActivation.text =
    mkIf brewEnabled # bash
      ''
        if [ ! -f ${config.homebrew.brewPrefix}/brew ]; then
          ${pkgs.bash}/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
      '';

  homebrew.enable = true;
  homebrew.brews = [ ];
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.masApps = {
    Wireguard = 1451685025;
    "WhatsApp" = 310633997;
  };

  homebrew.casks = [
    "1password"
    "1password-cli"
    "pritunl"
    "logi-options+"

    "mist"
    "moonlight"
    "mounty"
  ];

}
