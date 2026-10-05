{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.metronome.apps.pavucontrol;
in
{

  options.metronome.apps.pavucontrol = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install pavucontrol";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.pavucontrol ];
  };
}
