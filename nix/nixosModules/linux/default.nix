{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Core CLI packages
    ./packages.nix
    
    # Shell configuration
    ./fish.nix
    ./starship.nix
    
    # GUI apps - only included if not running in WSL
    (lib.mkIf (!config.wsl.enable or false) ./apps.nix)
  ];
} 