{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (osConfig.custom.dev.typescript.runtime == "nodejs") [
    pkgs.nodejs
  ];
}
