{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.zathura;
  isDefault = (config.metronome.defaults.pdf-viewer == "zathura");
in
{
  options.metronome.apps.zathura = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable btop system monitor";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
