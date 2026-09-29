{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.pwvucontrol.enable = lib.mkEnableOption "pwvucontrol";

  config = lib.mkIf config.custom.apps.pwvucontrol.enable {

    home.packages = with pkgs; [
      pwvucontrol
    ];
  };
}
