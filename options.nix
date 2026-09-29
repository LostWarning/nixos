{ lib, ... }:

{
  options.custom = {
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
  };
}
