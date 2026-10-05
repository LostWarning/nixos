{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.services.docker;
in
{
  options.metronome.services.docker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable docker";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };

}
