{ ... }: {
  boot.kernelModules = [ "uinput" ];

  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = { };

  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''

(defalias
  cec (tap-hold 200 200 esc lctl)

  default (tap-hold 200 200 grv (layer-switch default))
  gallium (tap-hold 200 200 grv (layer-switch gallium))

  b-media (tap-hold 200 200 b (layer-toggle symbols))
  m-mov (tap-hold 200 200 m (layer-toggle movement))
  w-sym (tap-hold 200 200 w (layer-toggle symbols))
  f-num (tap-hold 200 200 f (layer-toggle numbers))

  n-lmet (tap-hold 200 200 n lmet)
  r-lalt (tap-hold 200 200 r lalt)
  t-lctl (tap-hold 200 200 t lctl)
  s-lsft (tap-hold 200 200 s lsft)

  h-rsft (tap-hold 200 200 h rsft)
  a-rctl (tap-hold 200 200 a rctl)
  e-ralt (tap-hold 200 200 e ralt)
  i-rmet (tap-hold 200 200 i rmet)

  d nop8
)

(defsrc
  esc      f1       f2      f3      f4      f5   f6    f7      f8      f9      f10     f11  f12
  grv      1        2       3       4       5    6     7       8       9       0       -    =    bspc
  tab      q        w       e       r       t    y     u       i       o       p       [    ]    \
  caps     a        s       d       f       g    h     j       k       l       ;       '    ret
  lsft     z        x       c       v       b    n     m       ,       .       /       rsft
  lctl     lmet     lalt    spc     ralt    rmet rctl
)

(deflayer default
  esc      f1       f2      f3      f4      f5   f6    f7      f8      f9      f10     f11  f12
  @gallium 1        2       3       4       5    6     7       8       9       0       -    =    bspc
  tab      q        w       e       r       t    y     u       i       o       p       [    ]    \
  caps     a        s       d       f       g    h     j       k       l       ;       '    ret
  lsft     z        x       c       v       b    n     m       ,       .       /       rsft
  lctl     lmet     lalt    spc     ralt    rmet rctl
)

(deflayer gallium
  esc      f1       f2      f3      f4      f5   f6    f7      f8      f9      f10     f11  f12
  @default @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d   bspc
  tab      @b-media l       d       c       v    z     y       o       u       ,       /    @d   @d
  esc      @n-lmet  @r-lalt @t-lctl @s-lsft g    p     @h-rsft @a-rctl @e-ralt @i-rmet -    ret
  @d       q        x       @m-mov  @w-sym  j    k     @f-num  '       ;       .       @d
  @d       @d       bspc    spc     ret     @d   @d
)

(deflayer symbols
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d
  @d       @d       @d      @d      @d      @d   S-grv S-,     S-.     S-6     grv     \    @d   bspc
  @d       @d       @d      @d      @d      @d   S-\   [       ]       S-2     S-1     S-/  @d   @d
  @d       @d       @d      @d      @d      @d   S-7   S-9     S-0     S-4     S-3     S--  @d
  @d       @d       @d      @d      @d      @d   =     S-[     S-]     S-=     S-8     S-5
  @d       @d       bspc    spc     ret     @d   @d
)

(deflayer numbers
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d   bspc
  @d       -        7       8       9       /    @d    @d      @d      @d      @d      @d   @d   @d
  @d       S-=      4       5       6       S-8  @d    @d      @d      @d      @d      @d   @d
  @d       0        1       2       3       =    @d    @d      @d      @d      @d      @d
  @d       @d       bspc    spc     ret     @d   @d
)

(deflayer movement
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d   bspc
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d   @d
  @d       @d       @d      @d      @d      @d   left  down    up      rght   @d      @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d
  @d       @d       bspc    spc     ret     @d   @d
)

(deflayer blank
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d   @d
  @d       @d       @d      @d      @d      @d   @d    @d      @d      @d      @d      @d
  @d       @d       @d      @d      @d      @d   @d
)
        '';
      };
    };
  };
}
