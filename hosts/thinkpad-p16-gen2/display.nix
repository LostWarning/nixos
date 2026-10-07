{ ... }:

let
  thinkpadP16Gen2Display = import ../../hardware/monitor/lenovo/thinkpad-p16-gen2.nix;
  dellS2725QS = import ../../hardware/monitor/dell/s2725qs.nix;
in
{
  metronome.hardware.displays = {
    "eDP-1" = thinkpadP16Gen2Display // {
      position = "0x0";
      primary = true;
    };
    "DP-5" = dellS2725QS // {
      position = "2560x0";
    };
  };
}
