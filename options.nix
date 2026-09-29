{ lib, ... }:

{
  options.custom = {

    window_manager = lib.mkOption {
      type = lib.types.enum [
        "hyprland"
        "gnome"
        "kde"
      ];
      default = "hyprland";
      description = "Select which window manager to use.";
    };

    audio.backend = lib.mkOption {
      type = lib.types.enum [
        "pipewire"
        "none"
      ];
      default = "pipewire";
      description = "Select which audio backend system to use.";
    };

    terminal = {
      emulator = lib.mkOption {
        type = lib.types.enum [
          "kitty"
          "alacritty"
          "none"
        ];
        default = "kitty";
        description = "Terminal emulator to use";
      };

      shell = lib.mkOption {
        type = lib.types.enum [
          "fish"
          "zsh"
          "bash"
        ];
        default = "fish";
        description = "Default user shell";
      };

      prompt = lib.mkOption {
        type = lib.types.enum [
          "starship"
          "blesh"
          "none"
        ];
        default = "starship";
        description = "Prompt or styler/engine";
      };
    };

    editors = {
      neovim.enable = lib.mkEnableOption "Neovim text editor";
      vim.enable = lib.mkEnableOption "Vim text editor";
      nano.enable = lib.mkEnableOption "nano text editor";

      default = lib.mkOption {
        type = lib.types.enum [
          "neovim"
          "vim"
          "nano"
        ];
        default = "neovim";
        description = "Default editor";
      };
    };

    dev = {
      cxx.enable = lib.mkEnableOption "C++ development toolchain";

      typescript = {
        enable = lib.mkEnableOption "TypeScript/JavaScript development toolchain";
        runtime = lib.mkOption {
          type = lib.types.enum [
            "nodejs"
            "bun"
          ];
          default = "nodejs";
          description = "Preferred JS runtime";
        };
        nodejs = {
          packageManger = lib.mkOption {
            type = lib.types.enum [
              "npm"
              "pnpm"
            ];
            default = "npm";
            description = "Preferred Node.js package manager";
          };
        };
      };
    };
  };
}
