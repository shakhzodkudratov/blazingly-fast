{ pkgs, inputs, outputs, ... }: {
  users.users = {
    shakhzod = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      packages = (with pkgs; [
        firefox
        thunderbird
        tree
        git
        steam
        jetbrains.webstorm
        jetbrains.pycharm-professional
        jetbrains.goland
        jetbrains.rust-rover
        jetbrains.clion
        jetbrains.idea-ultimate
        jetbrains.datagrip
        jetbrains.phpstorm
        telegram-desktop
        nil
        nixpkgs-fmt
        _1password-gui
        termius
        spotify
      ])
      ++ (with pkgs.unstable; [
        vscode
        zed-editor
      ]);
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { shakhzod = import ./home.nix; };
  };
}
