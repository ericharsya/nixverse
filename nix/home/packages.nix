{ config, pkgs, ... }:

let
  inherit (pkgs.stdenv) isDarwin;
in
{
  # Packages with configuration --------------------------------------------------------------- {{{
  programs.home-manager.enable = true;

  programs.nix-index.enable = true;

  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.silent = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.btop.enable
  programs.btop.enable = true;
  programs.btop.settings = {
    vim_keys = true;
    show_battery = false;
  };

  home.packages = with pkgs;
    [
      ################################## 
      # Productivity
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
      zoom-us

      ################################## 
      # Development
      ##################################
      pkg-config
      sops
      kubectl
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
      postman

      ################################## 
      # Programming Stuff
      ##################################
      go-mockery
      go-migrate
      docker
      cloudflared
      mkcert
      dbeaver-community

      ################################## 
      # Shell Integrations
      ################################## 
      starship # theme for shell (bash,fish,zsh)
      tmux
      iterm2

      ################################## 
      # Misc
      ################################## 
      gnupg
      openssl
      ffmpeg
      telegram

      ################################## 
      # Useful Nix related tools
      ################################## 
      cachix
    
    ] ++ lib.optionals
      stdenv.isDarwin
      [
        mas
        m-cli # useful macOS CLI commands
        xcode-install
        rectangle
        raycast
        hidden-bar
        appcleaner
        shottr
        pinentry_mac
      ];
}
