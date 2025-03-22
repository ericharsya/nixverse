{
  config,
  pkgs,
  lib,
  ...
}:

{
  # GUI applications for Linux environments
  # These will only be installed if running on a Linux system with a GUI
  home.packages = with pkgs; [
    ################################## 
    # Browsers
    ##################################
    firefox
    chromium
    brave
    
    ################################## 
    # Development tools
    ##################################
    vscode
    dbeaver
    insomnia # REST client
    mongodb-compass
    
    ################################## 
    # Communication
    ##################################
    discord
    slack
    telegram-desktop
    
    ################################## 
    # Productivity
    ##################################
    obsidian
    libreoffice
    
    ################################## 
    # Utilities
    ##################################
    flameshot # Screenshot tool
    vlc
    filelight # Disk usage analyzer
    baobab # Disk usage analyzer (GNOME)
  ];
} 