{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    themeFile = "tokyo_night_night";

    shellIntegration.enableFishIntegration = true;
    extraConfig = builtins.readFile ./kitty/kitty.conf;
  };
}
