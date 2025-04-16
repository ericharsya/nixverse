{ pkgs, lib, ... }:

let
  budhilaw = {
    name = "Ericsson Budhilaw";
    email = "ericsson@budhilaw.com";
    signingKey = "0x936C2C581A15BB64"; # Replace with your actual GPG key ID
  };
in
{
  programs.git = {
    enable = true;
    userName = budhilaw.name;
    userEmail = budhilaw.email;
    signing = {
      key = budhilaw.signingKey;
      signByDefault = true;
    };

    ignores = [
      ".DS_Store"
    ];

    extraConfig = {
      gpg = {
        program = "${pkgs.gnupg}/bin/gpg2";
      };
      rerere.enable = true;
      commit.gpgSign = true;
      pull.ff = "only";
      diff.tool = "code";
      difftool.prompt = false;
      merge.tool = "code";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      init.defaultBranch = "main";
    };
  };

  ### git tools
  ## github cli
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };

  home.packages = [ pkgs.git-filter-repo ];
}
