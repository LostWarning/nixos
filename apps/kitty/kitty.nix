{
  config,
  lib,
  ...
}:

{
  options.custom.apps.kitty.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf config.custom.apps.kitty.enable {
    programs.kitty = {
      enable = true;

      themeFile = "tokyo_night_night";

      shellIntegration.enableFishIntegration = true;
      extraConfig = builtins.readFile ./kitty.conf;
    };
  };
}
