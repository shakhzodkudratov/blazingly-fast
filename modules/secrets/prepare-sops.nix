{ writeShellScriptBin, age }:
writeShellScriptBin "prepare-sops" ''
  set -euo pipefail

  SECRETS_DIR="/var/secrets"
  AGE_KEY_FILE="$SECRETS_DIR/age-key.txt"

  if [ ! -d "$SECRETS_DIR" ]; then
    echo "Creating $SECRETS_DIR..."
    sudo mkdir -p "$SECRETS_DIR"
    sudo chmod 700 "$SECRETS_DIR"
  fi

  if [ ! -f "$AGE_KEY_FILE" ]; then
    echo "Generating age key..."
    ${age}/bin/age-keygen 2>/dev/null | sudo tee "$AGE_KEY_FILE" > /dev/null
    sudo chmod 600 "$AGE_KEY_FILE"
  fi

  AGE_PUB=$(sudo grep -o 'age1.*' "$AGE_KEY_FILE" | head -1)
  echo "Age public key: $AGE_PUB"
  echo "Done. Now run: opsops-full"
''
