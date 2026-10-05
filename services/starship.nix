{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.services.starship;
  isDefault = (config.metronome.defaults.shell-prompt == "starship");
in

{
  options.metronome.services.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "enable sharship prompt";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}
