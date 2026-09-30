{ lib, ... }:

{
  options.metronome.dev = {
    typescript = {
      enable = lib.mkEnableOption "TypeScript/JavaScript development toolchain";
      nodejs.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Nodejs runtime";
      };
      bun.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "bun runtime";
      };
    };
  };
}
