{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.cpp;
in
{
  options.metronome.apps.cpp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable C/C++ development tools (Clang/LLVM, CMake, Ninja, Make, LLDB)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clang
      lldb
      cmake
      ninja
      gnumake
    ];
  };
}
