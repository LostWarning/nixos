{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.thunar;
  isDefault = (config.metronome.defaults.file-explorer == "thunar");
in
{
  options.metronome.apps.thunar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable thunar file explorer";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.thunar
      pkgs.thunar-archive-plugin # For right-click extract/compress
      pkgs.thunar-volman # For automatic management of removable drives
      pkgs.file-roller # Archive backend manager for Thunar
    ];
  };
}
