{
  osConfig,
  lib,
  ...
}:

let
  fishEnabled = osConfig.metronome.terminal.shell == "fish";
in
{
  programs.kitty = lib.mkIf (osConfig.metronome.terminal.emulator == "kitty") {
    enable = true;

    themeFile = "tokyo_night_night";

    shellIntegration.enableFishIntegration = fishEnabled;

    extraConfig = builtins.readFile ./kitty.conf;
  };
}
