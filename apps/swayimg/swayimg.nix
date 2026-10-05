{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.swayimg;
in
{
  options.metronome.apps.swayimg = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install swayimg";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.swayimg.enable = true;

    xdg.configFile."swayimg/init.lua".source = ./init.lua;
  };
}
