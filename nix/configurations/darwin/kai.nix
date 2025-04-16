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
  };

  services = {
    dnscrypt-proxy.enable = true;
    # when unbound `false` need to change dnscrypt listen address:
    dnscrypt-proxy.settings.listen_adresses = [ "127.0.0.1:53" ];
  };
}
