{ lib, ... }:

{
  options.metronome.dev = {
    cxx = {
      enable = lib.mkEnableOption "C++ development toolchain";

      compilers = {
        clang.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Clang/LLVM C/C++ compiler";
        };
        gcc.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "GCC C/C++ compiler";
        };
      };

      build_systems = {
        cmake.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "CMake build system";
        };
        ninja.enable = lib.mkOption {
          type = lib.type.bool;
          default = true;
          description = "Ninja build tool";
        };
        meson.enable = lib.mkOption {
          type = lib.type.bool;
          default = false;
          description = "Meson build tool";
        };
        make.enable = lib.mkOption {
          type = lib.type.bool;
          default = true;
          description = "Make build tools";
        };
      };

      diagnostics = {
        gdb.enable = lib.mkEnableOption "GDB debugger";
        lldb.enable = lib.mkEnableOption "LLDB debugger";
        valgrind.enable = lib.mkEnableOption "Valgrind memory debugger";
      };

      libraries = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Development libraries and headers (e.g., liburing)";
      };
    };
  };
}
