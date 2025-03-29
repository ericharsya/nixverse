{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in
{
  # Import nix-homebrew module
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # Remove the old activation script and shellInit since nix-homebrew will handle this
  # environment.shellInit = mkIf brewEnabled # bash
  #    ''
  #      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  #    '';

  # system.activationScripts.preUserActivation.text =
  #  mkIf brewEnabled # bash
  #    ''
  #      if [ ! -f ${config.homebrew.brewPrefix}/brew ]; then
  #        ${pkgs.bash}/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  #      fi
  #    '';

  # Enable both homebrew and nix-homebrew
  homebrew.enable = true;

  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

  nix-homebrew = {
    enable = true;
    user = "budhilaw"; # your username
    
    # Optional: Enable declarative tap management
    enableRosetta = true; # Enable if you want to use x86_64 homebrew packages on Apple Silicon (e.g., M1/M2 Mac)
    
    # Enable auto-migration to preserve installed packages while migrating to nix-homebrew
    autoMigrate = true;
    
    # Allow mutable taps during migration to prevent conflicts with existing taps
    mutableTaps = true;
    
    # Optional: use declarative taps
    taps = {
       "homebrew/homebrew-core" = inputs.homebrew-core;
       "homebrew/homebrew-cask" = inputs.homebrew-cask;
       "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
  };

  # nix-darwin homebrew configuration (still used for declarative package management)
  homebrew.onActivation = {
    cleanup = "uninstall";
    upgrade = true;
    autoUpdate = true;
  };
  homebrew.global.brewfile = true;

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
    "orbstack"
    "mongodb-compass"

    ##############
    # Productivity
    ##############
    "logi-options+"
    "brave-browser"
    "obs"
    "obsidian"
    "discord"
    "mendeley-reference-manager"
    "skype"

    ##############
    # Misc
    ##############
    "1password"
    "1password-cli"
    "android-file-transfer"
    "moonlight"
    "cloudflare-warp"
    "iina"
    "openvpn-connect"
  ];

  homebrew.brews = [
    ##############
    # Productivity
    ##############
    "terminal-notifier"
    "git"
  ];

}
