{ lib, ... }:

{
  options.metronome = {

    window_manager = lib.mkOption {
      type = lib.types.enum [
        "hyprland"
        "gnome"
        "kde"
      ];
      default = "hyprland";
      description = "Select which window manager to use.";
    };
  };
}
