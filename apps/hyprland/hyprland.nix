{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  config = lib.mkIf (osConfig.metronome.window_manager == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
    };

    xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
    xdg.configFile."hypr/monitors.lua".source = ../../hosts/desktop/monitors.lua;

    home.packages = with pkgs; [
      hyprcursor
      nordzy-cursor-theme
      hyprshot
      wl-clipboard
    ];
  };
}
