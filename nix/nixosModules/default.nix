{ ... }:
{
  flake.commonModules = {
    system-shells = import ./shells.nix;
    users-primaryUser = import ./user.nix;
  };

  flake.darwinModules = {
    system-darwin = import ./darwin/system.nix;
    system-darwin-gpg = import ./darwin/gpg.nix;
    system-darwin-homebrew = import ./darwin/homebrew.nix;
    # system-darwin-network = import ./darwin/network.nix;
    system-darwin-mac-app-util = import ./darwin/mac-app-util.nix;
  };
  
  flake.nixosModules = {
    system-wsl = import ./linux/wsl.nix;
    system-linux = import ./linux/default.nix;
    system-linux-packages = import ./linux/packages.nix;
    system-linux-apps = import ./linux/apps.nix;
    system-linux-fish = import ./linux/fish.nix;
    system-linux-starship = import ./linux/starship.nix;
  };
}
