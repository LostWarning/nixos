{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.nautilus.enable = lib.mkEnableOption "Nautilus";

  config = lib.mkIf config.custom.apps.nautilus.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}
