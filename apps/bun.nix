{
  osConfig,
  lib,
  ...
}:
let
  typescript = osConfig.metronome.dev.typescript;
in
{
  config = lib.mkIf (typescript.enable && typescript.bun.enable) {
    programs.bun = {
      enable = true;
    };
  };
}
