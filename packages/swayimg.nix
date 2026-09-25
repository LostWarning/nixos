{ pkgs, ... }:

{
  programs.swayimg.enable = true;

  xdg.configFile."swayimg/init.lua".source = ./swayimg/init.lua;

}
