{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.nautilus;
  isDefault = (config.metronome.defaults.file-explorer == "nautilus");
  term = config.metronome.defaults.terminal;
in

{
  options.metronome.apps.nautilus = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable nautilus file explorer";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nautilus ];

    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        sort-directories-first = true;
      };
    };

    xdg.desktopEntries.nvim = lib.mkIf isDefault {
      name = "Neovim";

      exec = "${term} -e nvim %F";
      terminal = false;
      type = "Application";
      categories = [
        "Utility"
        "TextEditor"
      ];
      mimeType = [
        "text/plain"
        "application/x-zerosize"
      ];
    };
  };
}
