{ inputs, pkgs, ... }:
let
  shared = import ./shared.nix { inherit pkgs inputs; };
in
{
  environment.systemPackages = shared ++ [ ];
  homebrew = {
    enable = true;
    taps = [
      "dart-lang/dart"
    ];
    brews = [
      "cocoapods"
      "dart"
    ];
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
      "little-snitch"

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
      "keymapp"
      "wakatime"
      "balenaetcher"
      "karabiner-elements"
      "font-jetbrains-mono-nerd-font"
      "logi-options+"
      "piphero"

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
      # RunCat = 1429033973;
    };
  };
}
