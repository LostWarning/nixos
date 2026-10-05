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
        # Themes & Appearance
        tokyonight-nvim

        # UI & Icons
        nvim-web-devicons
        nui-nvim
        plenary-nvim
        lualine-nvim
        barbecue-nvim
        nvim-navic
        indent-blankline-nvim

        # Navigation & Explorer
        neo-tree-nvim
        telescope-nvim
        project-nvim

        # Syntax & Highlighting (Grammars pre-compiled by Nix)
        (nvim-treesitter.withAllGrammars)

        # Autocompletion & Snippets
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp_luasnip
        luasnip

        # LSP & Environment
        nvim-lspconfig
        direnv-vim

        # Formatting, Diagnostics & Utilities
        trouble-nvim
        conform-nvim
        nvim-autopairs

        # Git Integration
        vim-fugitive
        gitsigns-nvim

        # Terminal
        toggleterm-nvim
      ];

      extraPackages = with pkgs; [
        # Language Servers
        lua-language-server
        nil
        clang-tools # clangd & clang-format
        rust-analyzer

        # Formatters & Linters
        stylua
        black
        isort
        rustfmt
        prettierd
        prettier
        jq

        # Fuzzy Finder & Treesitter CLI
        ripgrep
        fd
        tree-sitter
      ];

      initLua = builtins.readFile ./init.lua;
    };
  };
}
