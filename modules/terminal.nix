{
  config,
  lib,
  ...
}:

{
  options.custom.modules.terminal.enable = lib.mkEnableOption "terminal";

  config = lib.mkIf config.custom.modules.terminal.enable {
    custom.apps.kitty.enable = true;
    custom.apps.fish.enable = true;
    custom.apps.starship.enable = true;
  };
}
