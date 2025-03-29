{ ... }:
{
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  security.pam.services.sudo_local.touchIdAuth = false;
  # dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.showhidden = true;
  # keyboard UI
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  services.karabiner-elements.enable = false;

  # finder 
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  # trackpad
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = false;
  # Keyboard
  system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;

  services = {
    dnscrypt-proxy.enable = true;
    # when unbound `false` need to change dnscrypt listen address:
    # dnscrypt-proxy.settings.listen_adresses = [ "127.0.0.1:53" ]
    unbound.enable = true;
  };

  networking = {
    hostName = "budhilaw";
    knownNetworkServices = [
      "Wi-Fi"
      "USB 10/100/1000 LAN"
    ];
  };

  # Set DNS to use dnscrypt
  networking.dns = [
    "127.0.0.1"
  ];
}
