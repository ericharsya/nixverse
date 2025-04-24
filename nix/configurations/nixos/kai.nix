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

  # Set the system state version
  system.stateVersion = "23.11";
  
  # Set the platform to x86_64-linux
  nixpkgs.hostPlatform = "x86_64-linux";

  # User configuration
  users.users.kai = {
    isNormalUser = true;
    home = "/home/kai";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  # Enable basic services
  services = {
    xserver.enable = true;
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;
  };

  # Enable networking
  networking = {
    hostName = lib.mkDefault "kai";
    networkmanager.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
} 