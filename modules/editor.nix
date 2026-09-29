{ lib, ... }:

{
  options.metronome = {
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
