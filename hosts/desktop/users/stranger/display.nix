{ ... }:

{
  metronome.displays = {
    "DP-1" = {
      mode = "3840x2160@120";
      position = "1080x0";
      scale = 1.5;
      vrr = 2;
      bitdepth = 10;
      cm = "auto";
      primary = true;
      workspaces = [
        1
        2
        3
        4
        5
      ];
    };
    "DP-2" = {
      mode = "1920x1080@60";
      position = "0x0";
      scale = 1.0;
      transform = 3;
      bitdepth = 8;
      cm = "auto";
      workspaces = [
        6
        7
        8
        9
      ];
    };
  };
}
