{ pkgs, ... }: {
  i18n.inputMethod.enabled = null;
  hardware.keyboard.qmk.enable = true;
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
  '';
  services.xserver.xkb = {
    layout = "us";
    # layout = "us,us-custom";
    # variant = ",";
    # options = "grp:win_space_toggle";
    # extraLayouts.us-custom = {
    #   description = "Gallium alternative keyboard layout";
    #   languages = [ "eng" ];
    #   symbolsFile = pkgs.writeText "xkb-layout" ''
    #     xkb_symbols "us-custom" {
    #       include "us(basic)"

    #       name[Group1] = "Gallium";

    #       key <AD01> {[ b, B ]};
    #       key <AD02> {[ l, L ]};
    #       key <AD03> {[ d, D ]};
    #       key <AD04> {[ c, C ]};
    #       key <AD05> {[ v, V ]};
    #       key <AD06> {[ z, Z ]};
    #       key <AD07> {[ y, Y ]};
    #       key <AD08> {[ o, O ]};
    #       key <AD09> {[ u, U ]};
    #       key <AD10> {[ comma, less ]};
    #       key <AC01> {[ n, N ]};
    #       key <AC02> {[ r, R ]};
    #       key <AC03> {[ t, T ]};
    #       key <AC04> {[ s, S ]};
    #       key <AC05> {[ g, G ]};
    #       key <AC06> {[ p, P ]};
    #       key <AC07> {[ h, H ]};
    #       key <AC08> {[ a, A ]};
    #       key <AC09> {[ e, E ]};
    #       key <AC10> {[ i, I ]};
    #       key <AC11> {[ slash, question ]};
    #       key <AB01> {[ q, Q ]};
    #       key <AB02> {[ x, X ]};
    #       key <AB03> {[ m, M ]};
    #       key <AB04> {[ w, W ]};
    #       key <AB05> {[ j, J ]};
    #       key <AB06> {[ k, K ]};
    #       key <AB07> {[ f, F ]};
    #       key <AB08> {[ apostrophe, quotedbl ]};
    #       key <AB09> {[ semicolon, colon ]};
    #       key <AB10> {[ period, greater ]};
    #     };
    #   '';
    # };
  };
}

