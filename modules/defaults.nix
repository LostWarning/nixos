{ lib, ... }:

{
  options.metronome.defaults = {
    system-monitor = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "btop" ]);
      default = null;
      description = "Default system monitor";
    };

    terminal = lib.mkOption {
      type = lib.types.enum [
        "kitty"
      ];
      default = "kitty";
      description = "Default terminal";
    };

    web-browser = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "google-chrome" ]);
      default = null;
      description = "Default web browser";
    };

    file-explorer = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "nautilus"
          "thunar"
          "yazi"
        ]
      );
      default = null;
      description = "Default file explorer";
    };

    shell = lib.mkOption {
      type = lib.types.enum [
        "bash"
        "fish"
        "zsh"
      ];
      default = "bash";
      description = "Default shell";
    };

    shell-prompt = lib.mkOption {
      type = lib.types.enum [ "starship" ];
      default = "starship";
      description = "Default shell prompt";
    };

    desktop-environment = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "hyprland" ]);
      default = null;
      description = "Default desktop environment";
    };
  };
}
