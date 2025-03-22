{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.fish = {
    enable = true;
    
    plugins = with pkgs.fishPlugins; [
      # Syntax highlighting and suggestions
      { name = "z"; src = z.src; }
      { name = "done"; src = done.src; }
      { name = "forgit"; src = forgit.src; }
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "colored-man-pages"; src = colored-man-pages.src; }
      { name = "pisces"; src = pisces.src; } # Paired symbols in the command line
      { name = "bass"; src = bass.src; } # Use bash utilities in fish
    ];
    
    functions = {
      fish_greeting = "";
      
      # Git-related functions
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      
      # Clone and cd into a git repo
      clone = ''
        git clone $argv[1]
        cd (basename $argv[1] | sed 's/\.git$//')
      '';
      
      # Extract various archive formats
      extract = ''
        if test -f $argv[1]
          switch $argv[1]
            case '*.tar.bz2'
              tar xjf $argv[1]
            case '*.tar.gz'
              tar xzf $argv[1]
            case '*.bz2'
              bunzip2 $argv[1]
            case '*.rar'
              unrar x $argv[1]
            case '*.gz'
              gunzip $argv[1]
            case '*.tar'
              tar xf $argv[1]
            case '*.tbz2'
              tar xjf $argv[1]
            case '*.tgz'
              tar xzf $argv[1]
            case '*.zip'
              unzip $argv[1]
            case '*.Z'
              uncompress $argv[1]
            case '*'
              echo "'$argv[1]' cannot be extracted via extract"
          end
        else
          echo "'$argv[1]' is not a valid file"
        end
      '';
      
      # Quick directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      
      # Show the weather
      weather = "curl wttr.in";
      
      # Nix-specific functions
      nixclean = ''
        nix-collect-garbage -d
        nix store optimise
      '';
      
      # WSL-specific functions (only defined in WSL)
      winopen = "wsl-open $argv";
      
      # Run a command in PowerShell
      pwsh = "powershell.exe -Command $argv";
    };
    
    shellAliases = {
      # Navigation and ls
      l = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      
      # Git aliases
      g = "git";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gl = "git log --oneline --graph";
      gs = "git status";
      gp = "git push";
      gpl = "git pull";
      
      # Nix aliases
      ns = "nix-shell";
      nb = "nix build";
      nf = "nix flake";
      nr = "nix run";
      
      # System
      cat = "bat --style=plain";
      du = "dust";
      top = "btop";
      
      # WSL-specific aliases
      open = "wsl-open";
      code = "code-insiders";
    };
    
    shellInit = ''
      # Fix for WSL interop
      if test -d /mnt/c
        # WSL-specific settings
        set -x BROWSER wsl-open
      end
      
      # Add additional directories to PATH
      fish_add_path $HOME/.local/bin
      
      # Use starship prompt
      if type -q starship
        starship init fish | source
      end
    '';
    
    interactiveShellInit = ''
      # Fish color scheme
      set -U fish_color_command 6CB6EB --bold
      set -U fish_color_redirection DEB974
      set -U fish_color_operator DEB974
      set -U fish_color_end C071D8 --bold
      set -U fish_color_error EC7279 --bold
      set -U fish_color_param 6CB6EB
      set fish_greeting
      
      # Enable vi key bindings
      set -U fish_key_bindings fish_vi_key_bindings
      
      # Integration with direnv
      if type -q direnv
        direnv hook fish | source
      end
      
      # Integration with zoxide (smarter cd)
      if type -q zoxide
        zoxide init fish | source
      end
      
      # Integration with fzf
      if type -q fzf
        set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info"
        set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
        set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
      end
    '';
  };
} 