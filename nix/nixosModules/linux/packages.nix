{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    ################################## 
    # Linux-specific productivity tools
    ##################################
    lsd
    htop
    tldr
    jq
    fd
    wget
    curl
    eza
    fastfetch
    
    ################################## 
    # Linux development tools
    ##################################
    pkg-config
    sops
    kubectl
    docker
    
    ################################## 
    # Programming tools
    ##################################
    go-mockery
    go-migrate
    cloudflared
    mkcert
    
    ################################## 
    # Shell tools and Fish dependencies
    ################################## 
    starship
    tmux
    fzf      # Fuzzy finder for Fish
    bat      # Better cat
    zoxide   # Better cd
    direnv   # Directory-specific envs
    du-dust  # Better du
    eza      # Better ls (replacement for the deprecated exa)
    bash-completion   # Better completions for bash
    
    ################################## 
    # Misc
    ################################## 
    gnupg
    openssl
    ffmpeg
    git
    
    ################################## 
    # WSL-specific utilities
    ################################## 
    # Tools for better WSL/Windows integration
    wslu       # WSL utilities
    inotify-tools # File system monitoring
    zip
    unzip
    
    ################################## 
    # Useful Nix related tools
    ################################## 
    cachix
    nix-direnv
  ];
} 