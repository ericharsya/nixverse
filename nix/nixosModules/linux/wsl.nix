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
    defaultShell = "${pkgs.fish}/bin/fish";
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
  # Must enable fish at the system level for proper PATH
  programs = {
    fish = {
      enable = true;
      # Ensure Fish is properly set up for WSL
      useBabelfish = false;  # Don't use babelfish for WSL
      vendor.completions.enable = true;
      vendor.config.enable = true;
      vendor.functions.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "curses";  # Use curses for better WSL compatibility
    };
  };
  
  # Add fish to /etc/shells and set as default shell for user
  environment.shells = [ pkgs.fish ];
  users.users.budhilaw.shell = pkgs.fish;
  
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