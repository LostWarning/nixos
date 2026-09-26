{
  config,
  lib,
  ...
}:

{
  options.custom.apps.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.custom.apps.direnv.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
