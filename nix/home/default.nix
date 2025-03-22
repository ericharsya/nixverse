{ self, inputs, ... }:

{
  flake.homeManagerModules = {
    budhilaw-activation = import ./activation.nix;
    budhilaw-packages = import ./packages.nix;
    budhilaw-shell = import ./shells.nix;
    budhilaw-git = import ./git.nix;
    budhilaw-ssh = import ./ssh.nix;
    #budhilaw-tmux = import ./tmux.nix;
    gpg = import ./gpg.nix;
    home-user-info =
      { lib, ... }:
      {
        options.home.user-info =
          (self.commonModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
      };
  };
  
  # Standalone Home Manager configuration for Ubuntu WSL
  flake.homeConfigurations = {
    "budhilaw@WSL-PC" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config = { 
          allowUnfree = true;
          allowBroken = true;
        };
      };
      
      # Don't use all the modules since they might have dependencies that don't work on WSL
      # Instead, create a minimal config that works on WSL
      modules = [
        # Make pkgs available as a parameter to this module
        ({ config, pkgs, lib, ... }: {
          # Import Linux-specific configurations
          imports = [
            (import ../nixosModules/linux/packages.nix)
            (import ../nixosModules/linux/fish.nix)
            (import ../nixosModules/linux/starship.nix)
          ];
          
          home = {
            username = "budhilaw";
            homeDirectory = "/home/budhilaw";
            stateVersion = "24.11";
            
            # Define environment variables directly instead of using user-info
            sessionVariables = {
              EDITOR = "vim";
              EMAIL = "ericsson@budhilaw.com";
              GIT_AUTHOR_NAME = "Ericsson Budhilaw";
              GIT_AUTHOR_EMAIL = "ericsson@budhilaw.com";
              NIX_CONFIG_DIR = "/home/budhilaw/.config/nixverse";
            };
          };
          
          # Basic programs without complex configurations
          programs = {
            bash.enable = true;
            gpg.enable = true;
            
            git = {
              enable = true;
              userName = "Ericsson Budhilaw";
              userEmail = "ericsson@budhilaw.com";
            };
            
            # Override any fish/starship settings as needed
            fish.functions = {
              # Add WSL-specific functions here
              open-vscode = "code-insiders (wslpath -w $PWD)";
            };
          };
        })
      ];
    };
  };
}
