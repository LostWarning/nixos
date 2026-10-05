{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.starship;
  isDefault = (config.metronome.defaults.shell-prompt == "starship");
in

{

  options.metronome.apps.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "enable sharship prompt";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
