{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.btop;
  isDefault = (config.metronome.defaults.image-viewer == "imv");
in
{
  options.metronome.apps.imv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable imv image viewer";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.imv = {
      enable = true;
    };

    xdg.mimeApps = lib.mkIf isDefault {
      enable = true;
      defaultApplications = {
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/avif" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";
      };
    };
  };
}
