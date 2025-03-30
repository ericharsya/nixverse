{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    inputs.mac-app-util.darwinModules.default
  ];

  # Ensure the mac-app-util utility is available in the system path
  environment.systemPackages = [ 
    inputs.mac-app-util.packages.${pkgs.system}.default
  ];

  # Additional configuration options can be added here if needed
} 