{
  lib,
  config,
  options,
  osConfig ? null,
  ...
}:

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
      type = lib.types.nullOr (
        lib.types.enum [
          "hyprland"
          "gnome"
          "kde"
        ]
      );
      default = null;
      description = "Default desktop environment";
    };

    display-manager = lib.mkOption {
      type = lib.types.enum [ "greetd" ];
      default = "greetd";
      description = "Default display manager";
    };

    web-server = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "nginx" ]);
      default = null;
      description = "Default web server";
    };

    audio-backend = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "pipewire"
          "pulseaudio"
        ]
      );
      default = null;
      description = "Default audio backend";
    };

    text-editor = lib.mkOption {
      type = lib.types.enum [
        "nvim"
        "vim"
        "nano"
      ];
      default = "nvim";
      description = "Default text editor";
    };
  };

  config = lib.mkMerge [
    # Inside Home Manager, expose standard session variables
    (lib.optionalAttrs (options ? home) {
      home.sessionVariables = {
        EDITOR = config.metronome.defaults.text-editor;
        VISUAL = config.metronome.defaults.text-editor;
      }
      // (lib.optionalAttrs (config.metronome.defaults.terminal != null) {
        TERMINAL = config.metronome.defaults.terminal;
      })
      // (lib.optionalAttrs (config.metronome.defaults.web-browser != null) {
        BROWSER = config.metronome.defaults.web-browser;
      });
    })

    # Inside Home Manager, inherit system-level defaults from osConfig as defaults (can be overridden by user)
    (lib.optionalAttrs
      (options ? home && osConfig != null && osConfig ? metronome && osConfig.metronome ? defaults)
      {
        metronome.defaults = lib.mapAttrs (_name: value: lib.mkDefault value) (
          lib.filterAttrs (_n: v: v != null) osConfig.metronome.defaults
        );
      }
    )
  ];
}
