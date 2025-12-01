_: {
  homebrew = {
    enable = true;
    casks = [
      # Development Tools
      "docker-desktop"
      "visual-studio-code"
      "zed"
      "postman"
      "termius"
      "mongodb-compass"
      "jetbrains-toolbox"
      "proxyman"
      "utm"

      # Communication Tools
      "discord"
      "slack"
      "telegram"
      "zoom"
      "element"
      "zulip"

      # Utility Tools
      # "syncthing"
      "1password"
      "obsidian"
      "anytype"
      "keymapp"
      "wakatime"
      "balenaetcher"
      "karabiner-elements"
      "font-jetbrains-mono-nerd-font"
      "logi-options+"

      # Entertainment Tools
      "vlc"
      "spotify"
      "obs"
      "krita"
      "blender"

      # Productivity Tools
      "raycast"

      # Browsers
      "floorp"
      "google-chrome"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = {
      # "1password" = 1333542190;
      # Xcode = 497799835;
    };
  };
}
