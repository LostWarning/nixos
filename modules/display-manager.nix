{ lib, ... }:

{
  options.metronome = {
    display_manager = lib.mkOption {
      type = lib.types.enum [
        "greetd"
        "sddm"
        "none"
      ];
      default = "greetd";
      description = "Select which display manager to use.";
    };
  };
}
