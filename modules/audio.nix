{ lib, ... }:

{
  options.metronome.audio = {
    backend = lib.mkOption {
      type = lib.types.enum [
        "pipewire"
        "none"
      ];
      default = "pipewire";
      description = "Select which audio backend system to use.";
    };
  };
}
