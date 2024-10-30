# imported in @/flake.nix
{ nixpkgs, inputs, outputs }: {
  "workpc" = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ ./workpc/configuration.nix ];
  };

  "laptop" = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ ./laptop/configuration.nix ];
  };
}
