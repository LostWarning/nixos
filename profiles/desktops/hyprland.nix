{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.profiles.desktops.hyprland;
in
{

  options.metronome.profiles.desktops.hyprland = {
    enable = lib.mkEnableOption "Hyprland desktop environment profile";
  };

  config = lib.mkIf cfg.enable {
    # 1. Recommended defaults for this DE (can be overridden by the user!)
    metronome.defaults = {
      desktop-environment = lib.mkDefault "hyprland";
      terminal = lib.mkDefault "kitty";
      web-browser = lib.mkDefault "google-chrome";
      file-explorer = lib.mkDefault "nautilus";
      system-monitor = lib.mkDefault "btop";
      text-editor = lib.mkDefault "nvim";
    };

    # 2. Companion tools that make Hyprland a complete desktop
    metronome.apps = {
      quickshell.enable = lib.mkDefault true;
      swayimg.enable = lib.mkDefault true;
      pavucontrol.enable = lib.mkDefault true;
      pwvucontrol.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
    };
  };
}
