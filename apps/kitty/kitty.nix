{
  osConfig,
  lib,
  ...
}:

{
  programs.kitty = lib.mkIf (osConfig.custom.terminal.emulator == "kitty") {
    enable = true;

    themeFile = "tokyo_night_night";

    shellIntegration.enableFishIntegration = osConfig.custom.terminal.shell == "fish";

    extraConfig = builtins.readFile ./kitty.conf;
  };
}
