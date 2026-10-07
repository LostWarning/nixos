{ ... }:

let
  dellS2725QS = import ../../hardware/monitor/dell/s2725qs.nix;
  lenovoT24i30 = import ../../hardware/monitor/lenovo/t24i-30.nix;
in
{
  metronome.hardware.displays = {
    "DP-1" = dellS2725QS // {
      position = "1080x0";
      primary = true;
      workspaces = [
        1
        2
        3
        4
        5
      ];
    };
    "DP-2" = lenovoT24i30 // {
      position = "0x0";
      transform = 3;
      workspaces = [
        6
        7
        8
        9
      ];
    };
  };
}
