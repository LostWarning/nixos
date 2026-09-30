{ lib, ... }:

{
  options.metronome.ai = {
    enable = lib.mkEnableOption "LLM inference engine";

    engine = {
      ollama.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Ollama LLM inference engine";
      };
    };
  };
}
