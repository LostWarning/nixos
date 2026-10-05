{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.kitty;
  isDefault = (config.metronome.defaults.terminal == "kitty");
  isFishEnabled = (config.metronome.defaults.shell == "fish");
in
{
  options.metronome.apps.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable kitty terminal";
    };

    color-theme = lib.mkOption {
      type = lib.types.enum [
        "tokyo-night"
      ];
      default = "tokyo-night";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.kitty = {
      enable = true;

      themeFile = "tokyo_night_night";

      shellIntegration.enableFishIntegration = isFishEnabled;

      extraConfig = builtins.readFile ./kitty.conf;

    };
  };
}
