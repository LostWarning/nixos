{
  osConfig,
  lib,
  ...
}:

{
  config = lib.mkIf (osConfig.custom.dev.typescript.runtime == "bun") {
    programs.bun = {
      enable = true;
    };
  };
}
