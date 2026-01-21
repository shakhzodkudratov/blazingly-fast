{
  description = "blazingly fast nix config";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0";
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nmacs = {
      url = "git+https://codeberg.org/shakhzodkudratov/nmacs.git?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "https://flakehub.com/f/Mic92/sops-nix/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops = {
      url = "git+ssh://git@codeberg.org/shakhzodkudratov/sops.git?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.sops-nix.follows = "sops-nix";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
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

      nixosArgs = specialArgs // {
        isLinux = true;
        isDarwin = false;
      };

      darwinArgs = specialArgs // {
        isLinux = false;
        isDarwin = true;
      };

      supportedSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "aarch64-darwin" # 64-bit ARM macOS
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
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              self.formatter.${system}
              nixfmt-tree

              nixd
              deadnix
              statix

              git
            ];

            shellHook = ''
              export EDITOR="nvim"
              export FLAKE_ROOT="$(git rev-parse --show-toplevel)"
            '';
          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      nixosConfigurations.dreampad = nixpkgs.lib.nixosSystem {
        specialArgs = nixosArgs;
        modules = [
          modules.configurations.nixos
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen6
          ./hosts/linux/dreampad/configuration.nix
        ];
      };

      darwinConfigurations.powerlaptop = nix-darwin.lib.darwinSystem {
        specialArgs = darwinArgs;
        system = "aarch64-darwin";
        modules = [
          modules.configurations.darwin
          ./hosts/darwin/powerlaptop
        ];
      };
    };
}
