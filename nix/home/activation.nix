{ pkgs, lib, config, ... }:

{
  home.activation = {
    # This will run after mac-app-util has created the trampolines
    registerAppTrampolinesWithLaunchpad = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # Force rebuild the LaunchServices database and touch all apps to register them
      echo "Refreshing LaunchServices Database to register apps in Launchpad..."
      
      # Find all .app trampolines and touch them to update metadata
      if [ -d "$HOME/Applications/Home Manager Trampolines" ]; then
        echo "Updating app metadata..."
        find "$HOME/Applications/Home Manager Trampolines" -name "*.app" -exec touch "{}/Contents/Info.plist" \;
      fi
      
      # Reset LaunchServices database
      echo "Resetting LaunchServices database..."
      if [ -x "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister" ]; then
        /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
      fi
      
      # Force rebuild the Launchpad database which should rediscover the apps
      echo "Resetting Launchpad database..."
      if [ -x "/usr/bin/defaults" ]; then
        /usr/bin/defaults write com.apple.dock ResetLaunchPad -bool true
      fi
      
      # Rebuild Spotlight index if mdimport exists
      if [ -x "/usr/bin/mdimport" ]; then
        echo "Rebuilding Spotlight index..."
        /usr/bin/mdimport "$HOME/Applications/Home Manager Trampolines"
      fi
      
      # Restart Dock to show changes
      echo "Restarting Dock..."
      if [ -x "/usr/bin/killall" ]; then
        /usr/bin/killall Dock || true
      fi
      
      echo "App registration complete. It may take a moment for all apps to appear in Launchpad."
    '';
  };
}
