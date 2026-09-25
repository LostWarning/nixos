{ pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      direnv-vim
      nvim-lspconfig
    ];

    extraPackages = with pkgs; [

      # git
      git

      # Lua
      lua-language-server
      stylua

      # nix
      nil

      # C/C++
      clang-tools
      clang
      gnumake
      cmake

      # Telescope Dependencies
      ripgrep
      fd

      tree-sitter

    ];

    initLua = builtins.readFile ./nvim/init.lua;
  };
}
