{
  osConfig,
  lib,
  ...
}:

{
  config = lib.mkIf (builtins.elem "bun" osConfig.metronome.dev.typescript.runtimes) {
    programs.bun = {
      enable = true;
    };
  };
}
