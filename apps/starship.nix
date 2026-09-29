{
  osConfig,
  lib,
  ...
}:

{
  programs.starship = lib.mkIf (osConfig.metronome.terminal.prompt == "starship") {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
