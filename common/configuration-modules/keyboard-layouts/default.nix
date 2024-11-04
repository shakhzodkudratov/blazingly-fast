{ pkgs, ... }: {
  i18n.inputMethod.enabled = null;
  services.xserver.xkb = {
    layout = "us,us-custom";
    variant = ",";
    options = "grp:win_space_toggle";
    extraLayouts.us-custom = {
      description = "Gallium alternative keyboard layout";
      languages = [ "eng" ];
      symbolsFile = pkgs.writeText "xkb-layout" ''
        xkb_symbols "us-custom" {
          include "us(basic)"

          name[Group1] = "Gallium";

          key <AD01> {[ b, B ]};
          key <AD02> {[ l, L ]};
          key <AD03> {[ d, D ]};
          key <AD04> {[ c, C ]};
          key <AD05> {[ v, V ]};
          key <AD06> {[ z, Z ]};
          key <AD07> {[ y, Y ]};
          key <AD08> {[ o, O ]};
          key <AD09> {[ u, U ]};
          key <AD10> {[ comma, less ]};
          key <AC01> {[ n, N ]};
          key <AC02> {[ r, R ]};
          key <AC03> {[ t, T ]};
          key <AC04> {[ s, S ]};
          key <AC05> {[ g, G ]};
          key <AC06> {[ p, P ]};
          key <AC07> {[ h, H ]};
          key <AC08> {[ a, A ]};
          key <AC09> {[ e, E ]};
          key <AC10> {[ i, I ]};
          key <AC11> {[ slash, question ]};
          key <AB01> {[ q, Q ]};
          key <AB02> {[ x, X ]};
          key <AB03> {[ m, M ]};
          key <AB04> {[ w, W ]};
          key <AB05> {[ j, J ]};
          key <AB06> {[ k, K ]};
          key <AB07> {[ f, F ]};
          key <AB08> {[ apostrophe, quotedbl ]};
          key <AB09> {[ semicolon, colon ]};
          key <AB10> {[ period, greater ]};
        };
      '';
    };
  };
}

