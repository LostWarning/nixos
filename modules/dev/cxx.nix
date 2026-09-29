{ lib, ... }:

{
  options.metronome.dev = {
    cxx = {
      enable = lib.mkEnableOption "C++ development toolchain";
      toolchain = lib.mkOption {
        type = lib.types.listOf (
          lib.types.enum [
            "gcc"
            "clang"
          ]
        );
        default = [ "clang" ];
        description = "List of c/cxx toolchains provider";
      };

      buildSystems = lib.mkOption {
        type = lib.types.listOf (
          lib.types.enum [
            "cmake"
            "ninja"
            "make"
            "meson"
          ]
        );
        default = [
          "cmake"
          "ninja"
        ];
        description = "Build systems";
      };

      diagnostics = lib.mkOption {
        type = lib.type.listOf (
          lib.types.enum [
            "gdb"
            "lldb"
            "valgrind"
            "strace"
            "perf"
          ]
        );
        default = [
          "gdb"
          "valgrind"
        ];
        description = "Debugger, profilers and system tracers";
      };

      libraries = lib.mkOption {
        type = lib.types.listOf lib.type.str;
        default = [ ];
        description = "Development libraries and headers (e.g., liburing)";
      };
    };

  };
}
