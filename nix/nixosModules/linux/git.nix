{
  pkgs,
  lib,
  ...
}:

let
  budhilaw = {
    name = "Ericsson Budhilaw";
    email = "ericsson@budhilaw.com";
    signingKey = "0x936C2C581A15BB64"; # User's GPG key ID
  };
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.git;
  };

  # System-wide git configuration
  environment.etc = {
    "gitconfig".text = ''
      [user]
        name = ${budhilaw.name}
        email = ${budhilaw.email}
        signingkey = ${budhilaw.signingKey}

      [commit]
        gpgsign = true

      [gpg]
        program = ${pkgs.gnupg}/bin/gpg2

      [init]
        defaultBranch = main

      [pull]
        ff = only

      [push]
        autoSetupRemote = true

      [url "git@github.com:"]
        insteadOf = https://github.com/
    '';
  };

  # Additional git-related tools
  environment.systemPackages = with pkgs; [
    gh # GitHub CLI
    git-filter-repo
  ];
} 