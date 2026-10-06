{ lib, ... }:

{
  options.metronome.hardware.displays = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          options = {
            output = lib.mkOption {
              type = lib.types.str;
              default = name;
              description = "Connector name (e.g. eDP-1, DP-1, HDMI-A-1)";
            };

            mode = lib.mkOption {
              type = lib.types.str;
              default = "preferred";
              example = "3840x2160@120";
              description = "Resolution and refresh rate (WIDTHxHEIGHT[@REFRESH])";
            };

            position = lib.mkOption {
              type = lib.types.str;
              default = "0x0";
              example = "1080x0";
              description = "Display position in global layout (XxY)";
            };

            scale = lib.mkOption {
              type = lib.types.either lib.types.int lib.types.float;
              default = 1.0;
              description = "Display scaling factor";
            };

            primary = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Whether this is the primary display";
            };

            transform = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
              example = 3;
              description = "Display rotation/transform (0 = normal, 1 = 90, 2 = 180, 3 = 270)";
            };

            vrr = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
              example = 2;
              description = "Variable Refresh Rate (0 = off, 1 = on, 2 = fullscreen only)";
            };

            bitdepth = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
              example = 10;
              description = "Color bit depth";
            };

            cm = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              example = "auto";
              description = "Color management profile/mode";
            };

            workspaces = lib.mkOption {
              type = lib.types.listOf lib.types.int;
              default = [ ];
              example = [
                1
                2
                3
                4
                5
              ];
              description = "Workspaces pinned to this monitor";
            };
          };
        }
      )
    );
    default = { };
    description = "Physical display configurations for this machine";
  };
}
