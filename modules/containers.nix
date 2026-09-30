{ lib, ... }:

{
  options.metronome.containers = {
    enable = lib.mkEnableOption "Enable containers";

    docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Docker container runtime";
    };
  };
}
