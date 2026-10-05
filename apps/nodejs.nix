{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.metronome.apps.nodejs;
in
{
  options.metronome.apps.nodejs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install nodejs";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nodejs ];
  };
}
