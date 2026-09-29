{
  osConfig,
  lib,
  ...
}:

{
  programs.starship = lib.mkIf (osConfig.custom.terminal.prompt == "starship") {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
