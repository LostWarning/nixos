{
  osConfig,
  lib,
  ...
}:

{
  config = lib.mkIf (builtins.elem "bun" osConfig.custom.dev.typescript.runtimes) {
    programs.bun = {
      enable = true;
    };
  };
}
