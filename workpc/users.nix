{ pkgs, inputs, outputs, ... }: {
  users.users = {
    shakhzod = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      packages = (with pkgs; [
        firefox
        google-chrome
        thunderbird
        tree
        git
        steam
        jetbrains-toolbox
        telegram-desktop
        nil
        nixpkgs-fmt
        _1password-gui
        termius
        spotify
        python3
        virtualenv
        bruno
        htop
        inetutils
        element-desktop
        libsForQt5.kleopatra
        llvmPackages.llvm
        llvmPackages.clang
        cmake
        onlyoffice-bin_latest
      ])
      ++ (with pkgs.n2311; [
        nodejs_21
        nodePackages.pnpm
      ])
      ++ (with pkgs.unstable; [
        vscode
        zed-editor
        discord
        postman
      ]);
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { shakhzod = import ./home.nix; };
  };
}
