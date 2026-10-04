{
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.metronome.apps.google-chrome;
  isDefault = (config.metronome.defaults.web-browser == "google-chrome");
in

{
  options.metronome.apps.google-chrome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "install Google Chrome";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.google-chrome = {
        enable = true;
      };
    };
  };
}
