{
  config,
  pkgs,
  lib,
  ...
}:

let
  ai = config.metronome.ai;
in
{
  config = lib.mkIf (ai.enable && ai.engine.ollama.enable) {
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
