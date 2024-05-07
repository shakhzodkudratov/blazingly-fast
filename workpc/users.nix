{ pkgs, inputs, outputs, ... }: {
  users.users = {
    shakhzod = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      packages = (with pkgs.n2311; [
        firefox
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
        rustup
        nodejs_21
        nodePackages.pnpm
        python3
        virtualenv
        bruno
        anki-bin
        ocaml
        dune_3
        ocamlPackages.findlib
        ocamlPackages.re
        htop
        inetutils
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
