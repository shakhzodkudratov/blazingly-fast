{
  writeShellScriptBin,
  git,
  opsops,
  sops,
  nixfmt-rfc-style,
}:
writeShellScriptBin "opsops-full" ''
  set -euo pipefail

  AGE_PUB=$(sudo grep -o 'age1.*' /var/secrets/age-key.txt | head -1)
  FLAKE_ROOT="$(${git}/bin/git rev-parse --show-toplevel)"
  OPSOPS_YAML="$FLAKE_ROOT/modules/secrets/opsops.yaml"
  OPSOPS_NIX="$FLAKE_ROOT/modules/secrets/opsops.nix"
  SECRETS_DIR="/var/secrets"
  SECRETS_OUTPUT="$SECRETS_DIR/opsops.yaml"

  sudo mkdir -p "$SECRETS_DIR"

  ${opsops}/bin/opsops render --input "$OPSOPS_YAML" \
    | ${sops}/bin/sops encrypt \
      --age "$AGE_PUB" \
      --input-type=yaml \
      --output-type=yaml \
      --filename-override secrets/opsops.yaml \
      /dev/stdin \
    | sudo tee "$SECRETS_OUTPUT" > /dev/null

  {
    echo "{"
    ${opsops}/bin/opsops snippet sops-nix --input "$OPSOPS_YAML"
    echo "}"
  } > "$OPSOPS_NIX"

  ${nixfmt-rfc-style}/bin/nixfmt "$OPSOPS_NIX"
  echo "Done."
''
