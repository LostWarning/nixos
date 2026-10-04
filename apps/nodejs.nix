{
  config,
  lib,
  pkgs,
  username,
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
    home-manager.users.${username} = {
      home.packages = [ pkgs.nodejs ];
    };
  };
}
