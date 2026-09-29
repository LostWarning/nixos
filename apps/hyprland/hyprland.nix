{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  config = lib.mkIf (osConfig.custom.window_manager == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;

      extraConfig = builtins.readFile ./hyprland.lua;
    };

    home.packages = with pkgs; [
      hyprcursor
      nordzy-cursor-theme
      hyprshot
      wl-clipboard
    ];
  };
}
