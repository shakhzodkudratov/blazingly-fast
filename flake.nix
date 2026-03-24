{
  description = "blazingly fast nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };

    opsops = {
      url = "github:vst/opsops";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      # https://git.lix.systems/lix-project/lix/tags
      url = "https://git.lix.systems/lix-project/lix/archive/2.95.1.tar.gz";
      flake = false;
    };

    lix-module = {
      # https://git.lix.systems/lix-project/nixos-module/tags
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      globalib = nixpkgs.lib // home-manager.lib // (import ./lib);
      modules = import ./modules;

      specialArgs = {
        inherit inputs globalib modules;
      };

      darwinArgs = specialArgs // {
        isLinux = false;
        isDarwin = true;
      };

      supportedSystems = [
        # "x86_64-linux"
        # "aarch64-linux"
        # "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        let
          inherit
            (pkgs.callPackage ./modules/secrets/scripts.nix {
              inherit pkgs;
              inherit (inputs) opsops;
            })
            opsops-full
            prepare-sops
            ;
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              self.formatter.${system}
              nixfmt-tree

              nixd
              deadnix
              statix

              git

              opsops-full
              prepare-sops
            ];

            shellHook = ''
              export EDITOR="nvim"
              export FLAKE_ROOT="$(git rev-parse --show-toplevel)"
            '';
          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      darwinConfigurations = {
        powerlaptop = nix-darwin.lib.darwinSystem {
          specialArgs = darwinArgs;
          system = "aarch64-darwin";
          modules = [
            modules.configurations.darwin
            ./hosts/darwin/powerlaptop
          ];
        };
      };
    };
}
