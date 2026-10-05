{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.profiles.dev.node;
in
{
  options.metronome.profiles.dev.node = {
    enable = lib.mkEnableOption "Node.js & Bun development profile";
  };

  config = lib.mkIf cfg.enable {
    metronome.apps = {
      nodejs.enable = lib.mkDefault true;
      bun.enable = lib.mkDefault true;
    };
  };
}
