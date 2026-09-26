{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.thunar.enable = lib.mkEnableOption "Thunar";

  config = lib.mkIf config.custom.apps.thunar.enable {
    home.packages = with pkgs; [
      thunar
      thunar-archive-plugin # For right-click extract/compress
      thunar-volman # For automatic management of removable drives
      file-roller # Archive backend manager for Thunar
    ];
  };
}
