{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.profiles.dev.cpp;
in
{
  options.metronome.profiles.dev.cpp = {
    enable = lib.mkEnableOption "C++ development profile";
  };

  config = lib.mkIf cfg.enable {
    metronome.apps = {
      cpp.enable = lib.mkDefault true;
    };
  };
}
