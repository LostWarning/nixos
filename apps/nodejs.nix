{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  typescript = osConfig.metronome.dev.typescript;
in
{
  home.packages = lib.mkIf (typescript.enable && typescript.runtimes.nodejs.enable) [
    pkgs.nodejs
  ];
}
