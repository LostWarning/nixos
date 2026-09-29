{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.pavucontrol.enable = lib.mkEnableOption "pavucontrol";

  config = lib.mkIf config.custom.apps.pavucontrol.enable {

    home.packages = with pkgs; [
      pavucontrol
    ];
  };
}
