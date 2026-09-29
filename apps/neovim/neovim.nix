{
  osConfig,
  pkgs,
  lib,
  ...
}:

{
  programs.neovim = lib.mkIf osConfig.metronome.editors.neovim.enable {
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
}
