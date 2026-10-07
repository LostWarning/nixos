{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.metronome.services.greetd;
  isDefault = (config.metronome.defaults.display-manager == "greetd");
  defaultSessionCmd =
    if config.metronome.defaults.desktop-environment == "gnome" then
      "gnome-session"
    else if config.metronome.defaults.desktop-environment == "kde" then
      "startplasma-wayland"
    else
      "uwsm start -e -D Hyprland hyprland.desktop";
in
{

  options.metronome.services.greetd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable greetd display manager";
    };

    sessionCommand = lib.mkOption {
      type = lib.types.str;
      default = defaultSessionCmd;
      description = "Command executed by greetd / tuigreet session";
    };
  };

  config = lib.mkIf cfg.enable {

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '${cfg.sessionCommand}'";
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
