{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.theme;
in
{
  options.metronome.theme = {
    enable = lib.mkEnableOption "Metronome desktop theme management" // {
      default = true;
    };

    color-scheme = lib.mkOption {
      type = lib.types.enum [
        "prefer-dark"
        "prefer-light"
        "default"
      ];
      default = "prefer-dark";
      description = "Color scheme preference (dark/light mode)";
    };

    gtk = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Adwaita-dark";
        description = "GTK theme name";
      };
      package = lib.mkOption {
        type = lib.types.nullOr lib.types.package;
        default = pkgs.gnome-themes-extra;
        description = "GTK theme package";
      };
    };

    iconTheme = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Papirus-Dark";
        description = "Icon theme name";
      };
      package = lib.mkOption {
        type = lib.types.nullOr lib.types.package;
        default = pkgs.papirus-icon-theme;
        description = "Icon theme package";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = cfg.gtk.name;
        package = cfg.gtk.package;
      };
      iconTheme = {
        name = cfg.iconTheme.name;
        package = cfg.iconTheme.package;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = cfg.color-scheme;
      };
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        sort-directories-first = true;
      };
    };
  };
}
