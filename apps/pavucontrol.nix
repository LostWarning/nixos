{
  config,
  lib,
  pkgs,
  username,
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
    home-manager.users.${username} = {
      home.packages = [ pkgs.pavucontrol ];
    };
  };
}
