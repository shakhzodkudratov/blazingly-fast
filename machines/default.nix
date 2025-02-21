# imported in @/flake.nix
{ nixpkgs, inputs, outputs }: {
  "dreampad" = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ ./dreampad/configuration.nix ];
  };

  "laptop" = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ ./laptop/configuration.nix ];
  };
}
