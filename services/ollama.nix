{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.services.ollama;
in
{
  options.metronome.services.ollama = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ollama";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      host = "127.0.0.1";
      port = 11434;

      # Choose the package variant based on your hardware:
      # ----------------------------------------------------
      # package = pkgs.ollama;          # Default / CPU
      # package = pkgs.ollama-cuda;     # For NVIDIA GPUs
      package = pkgs.ollama-rocm; # For AMD GPUs
      # package = pkgs.ollama-vulkan;   # Universal GPU acceleration
    };
  };
}
