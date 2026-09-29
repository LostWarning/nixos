{
  osConfig,
  lib,
  ...
}:

let
  fishEnabled = osConfig.custom.terminal.shell == "fish";
in
{
  programs.kitty = lib.mkIf (osConfig.custom.terminal.emulator == "kitty") {
    enable = true;

    themeFile = "tokyo_night_night";

    shellIntegration.enableFishIntegration = fishEnabled;

    extraConfig = builtins.readFile ./kitty.conf;
  };
}
