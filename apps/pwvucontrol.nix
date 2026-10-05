{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.pwvucontrol;
in
{
  options.metronome.apps.pwvucontrol = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install pwvucontrol";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.pwvucontrol
    ];
  };

}
