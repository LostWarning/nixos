{ lib, ... }:

{
  options.metronome.dev = {
    typescript = {
      enable = lib.mkEnableOption "TypeScript/JavaScript development toolchain";
      runtimes = lib.mkOption {
        type = lib.types.listOf (
          lib.types.enum [
            "nodejs"
            "bun"
          ]
        );
        default = [ "nodejs" ];
        description = "List of JavaScript runtimes to install globally";
      };
    };

  };
}
