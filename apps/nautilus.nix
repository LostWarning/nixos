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
  home.packages = lib.mkIf file_explorer.nautilus.enable [
    pkgs.nautilus
  ];
}
