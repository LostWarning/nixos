{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (builtins.elem "nodejs" osConfig.custom.dev.typescript.runtimes) [
    pkgs.nodejs
  ];
}
