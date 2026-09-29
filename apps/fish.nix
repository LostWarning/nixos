{
  osConfig,
  lib,
  ...
}:

{
  programs.fish = lib.mkIf (osConfig.custom.terminal.shell == "fish") {
    enable = true;
  };
}
