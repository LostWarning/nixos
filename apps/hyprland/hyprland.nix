{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.metronome.apps.hyprland;
  isDefault = (config.metronome.defaults.desktop-environment == "hyprland");
in
{
  options.metronome.apps.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "enable hyprland desktop environment";
    };
  };

  config = lib.mkIf cfg.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
    };

    xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
    xdg.configFile."hypr/monitors.lua".source = ../../hosts/thinkpad-p16-gen2/monitors.lua;

    home.packages = with pkgs; [
      hyprcursor
      nordzy-cursor-theme
      hyprshot
      wl-clipboard
    ];
  };
}
