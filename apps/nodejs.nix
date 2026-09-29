{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (builtins.elem "nodejs" osConfig.metronome.dev.typescript.runtimes) [
    pkgs.nodejs
  ];
}
