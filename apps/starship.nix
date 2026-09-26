{
  config,
  lib,
  ...
}:

{
  options.custom.apps.starship.enable = lib.mkEnableOption "starship";

  config = lib.mkIf config.custom.apps.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
