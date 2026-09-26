{
  config,
  lib,
  ...
}:

{
  options.custom.apps.swayimg.enable = lib.mkEnableOption "Swayimg";

  config = lib.mkIf config.custom.apps.swayimg.enable {
    programs.swayimg.enable = true;

    xdg.configFile."swayimg/init.lua".source = ./config/swayimg/init.lua;
  };
}
