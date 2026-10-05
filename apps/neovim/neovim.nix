{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.nvim;
  isDefault = (config.metronome.defaults.text-editor == "nvim");
in

{
  options.metronome.apps.nvim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "install nvim";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        direnv-vim
        nvim-lspconfig
      ];

      extraPackages = with pkgs; [

        # Lua
        lua-language-server
        stylua

        # nix
        nil

        # Telescope Dependencies
        ripgrep
        fd

        tree-sitter

      ];

      initLua = builtins.readFile ./init.lua;
    };
  };
}
