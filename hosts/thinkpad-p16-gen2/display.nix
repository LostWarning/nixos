{ lib, ... }:

{
  metronome.displays = {
    "eDP-1" = {
      mode = lib.mkDefault "2560x1600@165";
      position = lib.mkDefault "0x0";
      scale = lib.mkDefault 1.0;
      vrr = lib.mkDefault 2;
      bitdepth = lib.mkDefault 10;
      cm = lib.mkDefault "auto";
      primary = lib.mkDefault true;
    };
    "DP-5" = {
      mode = lib.mkDefault "3840x2160@120";
      position = lib.mkDefault "2560x0";
      scale = lib.mkDefault 1.5;
      vrr = lib.mkDefault 2;
      bitdepth = lib.mkDefault 10;
      cm = lib.mkDefault "auto";
    };
  };
}
