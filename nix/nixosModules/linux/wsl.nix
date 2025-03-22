{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{
  # This module provides WSL-specific configurations
  
  # Import the WSL module from nixpkgs
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];
  
  # Enable the WSL integration
  wsl = {
    enable = true;
    defaultUser = "budhilaw";
    nativeSystemd = true;
    startMenuLaunchers = true;
    # WSL-specific settings
    wslConf = {
      network = {
        generateResolvConf = true;
      };
      interop = {
        enabled = true;
        appendWindowsPath = true;
      };
    };
  };
  
  # WSL-specific system configuration
  system.build.installBootLoader = lib.mkForce "${pkgs.coreutils}/bin/true";
  
  # Better file system compatibility
  boot.supportedFilesystems = [ "ntfs" ];
  
  # Enable nix flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };
  
  # WSL specific programs and configurations
  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  
  # System environment packages specific for WSL
  environment.systemPackages = with pkgs; [
    # CLI utilities useful in WSL
    curl
    wget
    git
    tmux
    ripgrep
    fd
    jq
    unzip
  ];
  
  # Networking configuration for WSL
  networking = {
    firewall.enable = false;
    useHostResolvConf = true;
    # WSL-specific networking configurations can be added here
  };
} 