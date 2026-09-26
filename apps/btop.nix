{
  config,
  lib,
  ...
}:

{
  options.custom.apps.btop.enable = lib.mkEnableOption "Btop";

  config = lib.mkIf config.custom.apps.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
