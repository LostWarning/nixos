{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    extraConfig = builtins.readFile ./hypr/hyprland.lua;
  };

  home.packages = with pkgs; [
    hyprcursor
    nordzy-cursor-theme
    hyprshot
    wl-clipboard
  ];
}
