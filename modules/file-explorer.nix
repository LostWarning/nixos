{ lib, ... }:

{
  options.metronome.file_explorer = {
    nautilus.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Nautilus File-Manager";
    };

    thunar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Thunar File-Manger";
    };
  };
}
