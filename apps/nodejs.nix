{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.nodejs.enable = lib.mkEnableOption "nodejs";

  config = lib.mkIf config.custom.apps.nodejs.enable {
    home.packages = with pkgs; [
      nodejs
    ];
  };
}
