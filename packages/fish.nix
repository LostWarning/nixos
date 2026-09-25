{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "ls -l";
      y = "yazi";
    };
  };
}
