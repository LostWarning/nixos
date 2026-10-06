{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.theme;

  themeMap = {
    "adwaita-dark" = {
      gtk = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      color-scheme = "prefer-dark";
    };
    "adwaita-light" = {
      gtk = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
      color-scheme = "prefer-light";
    };
    "tokyo-night" = {
      gtk = {
        name = "Tokyonight-Dark-BL";
        package = pkgs.tokyonight-gtk-theme;
      };
      color-scheme = "prefer-dark";
    };
    "nord" = {
      gtk = {
        name = "Nordic";
        package = pkgs.nordic;
      };
      color-scheme = "prefer-dark";
    };
  };

  iconMap = {
    "papirus-dark" = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    "papirus-light" = {
      name = "Papirus-Light";
      package = pkgs.papirus-icon-theme;
    };
    "adwaita" = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  cursorMap = {
    "nordzy" = {
      name = "Nordzy-cursors";
      hyprcursor = "Nordzy-hyprcursors";
      package = pkgs.nordzy-cursor-theme;
    };
    "adwaita" = {
      name = "Adwaita";
      hyprcursor = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  currentTheme = themeMap.${cfg.name} or {
    gtk = {
      name = cfg.name;
      package = null;
    };
    color-scheme = "prefer-dark";
  };

  currentIcon = iconMap.${cfg.icons} or {
    name = cfg.icons;
    package = null;
  };

  currentCursor = cursorMap.${cfg.cursor} or {
    name = cfg.cursor;
    hyprcursor = cfg.cursor;
    package = null;
  };
in
{
  options.metronome.theme = {
    enable = lib.mkEnableOption "Metronome unified theme management" // {
      default = true;
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "adwaita-dark";
      description = "Desktop theme preset (e.g. adwaita-dark, adwaita-light, tokyo-night, nord)";
    };

    icons = lib.mkOption {
      type = lib.types.str;
      default = "papirus-dark";
      description = "Icon theme preset (e.g. papirus-dark, papirus-light, adwaita)";
    };

    cursor = lib.mkOption {
      type = lib.types.str;
      default = "nordzy";
      description = "Cursor theme preset (e.g. nordzy, adwaita)";
    };

    cursor-size = lib.mkOption {
      type = lib.types.int;
      default = 24;
      description = "Cursor size in pixels";
    };

    hyprcursor = lib.mkOption {
      type = lib.types.str;
      default = currentCursor.hyprcursor;
      description = "Active Hyprcursor theme name";
    };
  };

  config = lib.mkIf cfg.enable {
    # Ensure cursor package is installed for system-wide and desktop lookups
    home.packages = lib.optional (currentCursor.package != null) currentCursor.package;

    # GTK styling
    gtk = {
      enable = true;
      theme = {
        name = currentTheme.gtk.name;
        package = currentTheme.gtk.package;
      };
      iconTheme = {
        name = currentIcon.name;
        package = currentIcon.package;
      };
    };

    # Qt styling: follows GTK
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };

    # Cursor management for X11, Wayland, GTK, and Hyprland
    home.pointerCursor = {
      enable = true;
      name = currentCursor.name;
      package = currentCursor.package;
      size = cfg.cursor-size;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
    };

    home.sessionVariables = {
      HYPRCURSOR_THEME = lib.mkForce currentCursor.hyprcursor;
    };

    # Desktop portal & GNOME dconf settings
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = currentTheme.color-scheme;
        cursor-theme = currentCursor.name;
        cursor-size = cfg.cursor-size;
      };
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        sort-directories-first = true;
      };
    };
  };
}
