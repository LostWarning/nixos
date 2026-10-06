{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.fish;
  isDefault = (config.metronome.defaults.shell == "fish");
in
{
  options.metronome.apps.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable fish shell configuration for user in Home Manager";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
