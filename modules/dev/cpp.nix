{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Define a custom toggle option for this module
  cfg = config.myCustom.dev.cpp;
in
{
  options.myCustom.dev.cpp = {
    enable = lib.mkEnableOption "C/C++ development toolchain and environment";
  };

  # Only install and configure these packages if `enable = true`
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Compilers & Build Tools
      clang
      gnumake
      cmake
      ninja

      # Debugging & Profiling
      valgrind
      gdb

      # Language Servers & Formatters
      clang-tools # Provides clangd and clang-format
      lldb
    ];

    # Optional: You can even configure environment variables or tools specific to C++ here!
    home.sessionVariables = {
      CC = "clang";
      CXX = "clang++";
    };
  };
}
