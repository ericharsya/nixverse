{
  lib,
  pkgs,
  ezModules,
  crossModules,
  config,
  ...
}:

{
  imports = lib.attrValues (ezModules // crossModules);

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.kai = {
    home = "/Users/kai";
    shell = pkgs.fish;
  };

  users.users._dnscrypt-proxy.home = lib.mkForce "/private/var/lib/dnscrypt-proxy";

  # --- see: nix/nixosModules/nix.nix
  # --- disabled because i use determinate nix installer
  # nix-settings = {
  #   enable = true;
  #   use = "full";
  #   inputs-to-registry = true;
  # };

  nix.enable = false;

  # --- nix-darwin
  homebrew.enable = true;

  networking = {
    hostName = lib.mkDefault "kai";
    computerName = config.networking.hostName;
    knownNetworkServices = ["Wi-Fi" "Ethernet" "USB 10/100/1000 LAN"];
  };

  services = {
    dnscrypt-proxy.enable = true;
    dnscrypt-proxy.settings.listen_addresses = [ "127.0.0.1:5353" ];
  };
}
