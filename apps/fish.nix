{
  config,
  lib,
  ...
}:

{
  options.custom.apps.fish.enable = lib.mkEnableOption "Fish shell";

  config = lib.mkIf config.custom.apps.fish.enable {
    programs.fish = {
      enable = true;
    };
  };
}
