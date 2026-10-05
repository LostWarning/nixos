{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.metronome.services.hyprland;
  isDefault = (config.metronome.defaults.desktop-environment == "hyprland");
in

{

  options.metronome.services.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "enable hyprland desktop environment";
    };
  };

  config = lib.mkIf cfg.enable {
    # Core Hyprland compositor
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # XDG Portals (screen sharing, file pickers)
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };

    # Polkit authentication agent
    security.polkit.enable = true;
    systemd.user.services.hyprpolkitagent = {
      description = "Hyprland Polkit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    programs.hyprlock.enable = true;
  };
}
