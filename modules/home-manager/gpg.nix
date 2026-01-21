{
  pkgs,
  lib,
  isDarwin,
  ...
}:
lib.mkMerge [
  (lib.mkIf isDarwin {
    home.file.".gnupg/gpg-agent.conf" = {
      text = ''
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        allow-preset-passphrase
        default-cache-ttl 600
        max-cache-ttl 7200
      '';
    };
  })
]
