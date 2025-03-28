{ ... }:
{
  flake.overlays.macos =
    final: prev:
    let
      inherit (prev.lib) attrsets;
      callPackage = prev.newScope { };
      packages = [
        "obs-studio"
        "orbstack"
        "telegram"
        "shottr"
        "dbeaver-community"
        "cursor"
        "jetbrains-toolbox"
      ];
    in

    attrsets.genAttrs packages (name: callPackage ./${name}.nix { });
}
