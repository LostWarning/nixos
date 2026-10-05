{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.metronome.services.greetd;
  isDefault = (config.metronome.defaults.display-manager == "greetd");
in
{

  options.metronome.services.greetd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable greetd display manager";
    };
  };

  config = lib.mkIf cfg.enable {

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start -e -D Hyprland hyprland.desktop'";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
