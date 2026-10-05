{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.btop;
  isDefault = (config.metronome.defaults.system-monitor == "btop");
in
{
  options.metronome.apps.btop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable btop system monitor";
    };

    color_theme = lib.mkOption {
      type = lib.types.enum [
        "tokyo-night"
      ];
      default = "tokyo-night";
      description = "Color theme";
    };
    theme_background = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use themes background";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = cfg.color_theme;
        theme_background = cfg.theme_background;
      };
    };
  };
}
