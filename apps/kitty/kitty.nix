{
  osConfig,
  lib,
  ...
}:

{
  programs.kitty = lib.mkIf (osConfig.custom.terminal.emulator == "kitty") {
    enable = true;

    themeFile = "tokyo_night_night";

    shellIntegration.enableFishIntegration = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };
}
