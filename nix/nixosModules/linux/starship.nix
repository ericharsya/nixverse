{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    
    settings = {
      # General settings
      add_newline = true;
      command_timeout = 1000;
      
      # Format for the prompt
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      
      # Individual component settings
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
        vicmd_symbol = "[ν](bold blue)";
      };
      
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only = " 󰌾";
        home_symbol = "~";
        style = "bold blue";
      };
      
      cmd_duration = {
        min_time = 500;
        format = "took [$duration](bold yellow) ";
        show_milliseconds = false;
      };
      
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style)@";
        disabled = false;
        show_always = false;
      };
      
      hostname = {
        ssh_only = false;
        format = "[$hostname](bold green) ";
        disabled = false;
      };
      
      # Git settings
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
      };
      
      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "bold red";
        ahead = "⇡$count ";
        behind = "⇣$count ";
        diverged = "⇕⇡$ahead_count⇣$behind_count ";
        conflicted = "=$count ";
        deleted = "✘$count ";
        modified = "!$count ";
        stashed = "*$count ";
        staged = "+$count ";
        renamed = "»$count ";
        untracked = "?$count ";
      };
      
      # Nix settings
      nix_shell = {
        format = "via [❄️ $name]($style) ";
        heuristic = true;
        style = "bold blue";
      };
      
      # Language settings
      rust = {
        format = "via [$symbol($version )]($style)";
        symbol = "🦀 ";
      };
      
      golang = {
        format = "via [$symbol($version )]($style)";
        symbol = "🐹 ";
      };
      
      nodejs = {
        format = "via [$symbol($version )]($style)";
        symbol = "⬢ ";
      };
      
      python = {
        format = "via [$symbol($version )]($style)";
        symbol = "🐍 ";
      };
      
      # Disable certain modules
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
    };
  };
} 