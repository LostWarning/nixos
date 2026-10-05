{ config, lib, ... }:

let
  cfg = config.metronome.services.ssh;
in
{
  options.metronome.services.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable ssh service";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh.startAgent = true;
  };

}
