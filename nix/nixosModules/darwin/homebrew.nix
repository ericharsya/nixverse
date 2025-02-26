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
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "homebrew/services"
    "gromgit/homebrew-fuse"
  ];

  homebrew.masApps = {
    Slack = 803453959;
    WhatsApp = 310633997;
    Wireguard = 1451685025;
  };

  homebrew.casks = [
    ##############
    # Fonts
    ##############
    "font-fira-mono-nerd-font"
    "font-inconsolata-go-nerd-font"
    "font-inconsolata-lgc-nerd-font"
    "font-inconsolata-nerd-font"
    "font-ubuntu-mono-nerd-font"
    "font-caskaydia-cove-nerd-font"
    "font-code-new-roman-nerd-font"
    "font-cousine-nerd-font"
    "font-daddy-time-mono-nerd-font"
    "font-dejavu-sans-mono-nerd-font"
    "font-droid-sans-mono-nerd-font"
    "font-fira-code-nerd-font"
    "font-go-mono-nerd-font"
    "font-gohufont-nerd-font"
    "font-hack-nerd-font"
    "font-jetbrains-mono-nerd-font"
    "font-liberation-nerd-font"
    "font-meslo-lg-nerd-font"
    "font-monoid-nerd-font"
    "font-mononoki-nerd-font"
    "font-noto-nerd-font"
    "font-roboto-mono-nerd-font"
    "font-shure-tech-mono-nerd-font"
    "font-ubuntu-nerd-font"
    "font-geist"
    "font-geist-mono"

    ##############
    # Tech
    ##############
    "cursor"
    "jetbrains-toolbox"
    "pritunl"
    "orbstack"
    "dbeaver-community"
    "mongodb-compass"

    ##############
    # Productivity
    ##############
    "logi-options+"
    "brave-browser"
    "obs"
    # "notion"
    # "obsidian"
    "siyuan"
    "discord"
    "mendeley-reference-manager"

    ##############
    # Misc
    ##############
    "1password"
    "1password-cli"
    
    "cloudflare-warp"
    "iina"
  ];

  homebrew.brews = [
    ##############
    # Productivity
    ##############
    "terminal-notifier"
  ];

}
