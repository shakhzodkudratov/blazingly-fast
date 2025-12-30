{ pkgs, ... }:
{
  # https://www.reddit.com/r/NixOS/comments/1o7148l/how_to_use_kanata_on_macbook_m2_with_nixdarwin/
  # does not work because of driver can fail: IOHIDDeviceOpen error: (iokit/common)
  # launchd = {
  #   daemons = {
  #     kanata = {
  #       command = "${pkgs.kanata}/bin/kanata -c ${./keyboard.kbd}";
  #       serviceConfig = {
  #         KeepAlive = true;
  #         RunAtLoad = true;
  #         StandardOutPath = "/tmp/kanata.out.log";
  #         StandardErrorPath = "/tmp/kanata.err.log";
  #       };
  #     };
  #   };
  # };

  environment.systemPackages = [
    pkgs.kanata
    (pkgs.writeScriptBin "kanata-gallium" ''
      sudo ${pkgs.kanata}/bin/kanata -c ${./keyboard.kbd}
    '')
  ];
}
