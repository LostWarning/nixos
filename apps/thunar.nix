{
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  file_explorer = osConfig.metronome.file_explorer;
in
{
  home.packages = lib.mkIf file_explorer.thunar.enable [
    pkgs.thunar
    pkgs.thunar-archive-plugin # For right-click extract/compress
    pkgs.thunar-volman # For automatic management of removable drives
    pkgs.file-roller # Archive backend manager for Thunar
  ];
}
