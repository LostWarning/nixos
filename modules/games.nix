{ lib, ... }:

{
  options.metronome.games = {
    enable = lib.mkEnableOption "Enable Games installaton";

    steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Steam games";
    };
  };
}
