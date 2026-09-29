{
  config,
  lib,
  ...
}:

{
  options.custom.apps.bun.enable = lib.mkEnableOption "bun";

  config = lib.mkIf config.custom.apps.bun.enable {
    programs.bun = {
      enable = true;
    };
  };
}
