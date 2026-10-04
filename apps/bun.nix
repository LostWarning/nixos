{
  config,
  lib,
  username,
  ...
}:
let
  cfg = config.metronome.apps.bun;
in
{
  options.metronome.apps.bun = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install bun";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.bun = {
        enable = true;
      };
    };
  };
}
