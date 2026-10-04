{
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.metronome.apps.direnv;
in
{
  options.metronome.apps.direnv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable direnv";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
