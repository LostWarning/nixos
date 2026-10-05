{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.services.ollama;
  gpu = config.metronome.hardware.gpu;

  # Dynamically pick the hardware-accelerated package variant:
  # - AMD: ROCm acceleration
  # - NVIDIA: CUDA acceleration
  # - Intel: Vulkan compute acceleration
  # - None / Fallback: Standard CPU package
  defaultPackage =
    if gpu == "amd" then
      pkgs.ollama-rocm
    else if gpu == "nvidia" then
      pkgs.ollama-cuda
    else if gpu == "intel" then
      pkgs.ollama-vulkan
    else
      pkgs.ollama;
in
{
  options.metronome.services.ollama = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ollama local LLM service";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      host = "127.0.0.1";
      port = 11434;

      package = lib.mkDefault defaultPackage;
    };
  };
}
