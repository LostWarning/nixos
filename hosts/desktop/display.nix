{ lib, ... }:

{
  metronome.displays = {
    "DP-1" = {
      mode = lib.mkDefault "3840x2160@120";
      position = lib.mkDefault "1080x0";
      scale = lib.mkDefault 1.5;
      vrr = lib.mkDefault 2;
      bitdepth = lib.mkDefault 10;
      cm = lib.mkDefault "auto";
      primary = lib.mkDefault true;
      workspaces = lib.mkDefault [
        1
        2
        3
        4
        5
      ];
    };
    "DP-2" = {
      mode = lib.mkDefault "1920x1080@60";
      position = lib.mkDefault "0x0";
      scale = lib.mkDefault 1.0;
      transform = lib.mkDefault 3;
      bitdepth = lib.mkDefault 8;
      cm = lib.mkDefault "auto";
      workspaces = lib.mkDefault [
        6
        7
        8
        9
      ];
    };
  };
}
