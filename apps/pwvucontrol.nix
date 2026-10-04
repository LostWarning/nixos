{
  config,
  lib,
  pkgs,
  username,
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
    home-manager.users.${username} = {
      home.packages = [
        pkgs.pwvucontrol
      ];
    };
  };

}
