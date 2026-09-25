vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
-- ============================================================================
-- 1. CORE OPTIONS & LEADER KEY
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- UI & Search
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Windows & Integration
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.updatetime = 250
opt.linespace = 0

-- Treesitter Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99 -- Start with all folds expanded when opening a file
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldcolumn = "1" -- Displays fold indicators in the sign column

-- Configure Diagnostic Display (Inline Virtual Text & Floating Popup)
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Automatically show floating diagnostic popup on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = " ",
			scope = "cursor",
		})
	end,
})

-- ============================================================================
-- 2. KEYMAPS
-- ============================================================================
local map = vim.keymap.set

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Toggle between Header and Source file in C/C++
-- map("n", "<leader>gh", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = ev.buf, desc = "Switch Header/Source" })

-- Toggle fold at cursor (collapse / expand block)
map("n", "<Tab>", "za", { desc = "Toggle fold/collapse code block" })
map("n", "<leader>zc", "zM", { desc = "Collapse all code blocks" })
map("n", "<leader>zo", "zR", { desc = "Expand all code blocks" })

-- ============================================================================
-- 3. LAZY.NVIM BOOTSTRAP
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ====================================================================
-- 4. direnv.vim integration
-- ====================================================================

-- Quiet direnv status messages in Neovim command line (optional)
vim.g.direnv_silent_load = 1

-- Restart LSPs automatically whenever direnv finishes loading/switching an environment
vim.api.nvim_create_autocmd("User", {
	pattern = "DirenvLoaded",
	callback = function()
		-- Only restart LSPs if lspconfig is loaded and active
		local ok, _ = pcall(require, "lspconfig")
		if ok then
			vim.cmd("LspRestart")
		end
	end,
})

-- ============================================================================
-- 5. PLUGINS SETUP
-- ============================================================================
require("lazy").setup({

	rocks = {
		enable = false,
	},
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	-- Modern Treesitter (v1.0+ API)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parsers = { "lua", "c", "cpp", "rust", "python", "bash", "nix", "json", "markdown", "glsl" }

			-- Modern Treesitter installation and setup
			require("nvim-treesitter").setup({
				ensure_installed = parsers,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- File Explorer (Neo-tree)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle File Explorer" },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
		},
	},

	-- Fuzzy Finder (Telescope)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find Text (Grep)" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find Help Tags" },
		},
	},

	-- Mason & Mason-LSPConfig
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {},
		},
	},

	-- Autocompletion Engine (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Native LSP Config (vim.lsp.config & vim.lsp.enable API)
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "direnv/direnv" },
		config = function()
			vim.g.direnv_silent_load = 1
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_config = {
				capabilities = capabilities,
				root_marker = { "flake.nix", ".git", ".envrc" },
			}

			-- Lua LSP
			vim.lsp.config.lua_ls = vim.tbl_deep_extend("force", default_config, {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			})

			-- C/C++, Rust, and Nix LSPs
			vim.lsp.config.clangd = default_config
			vim.lsp.config.rust_analyzer = default_config
			vim.lsp.config.nil_ls = default_config
			vim.lsp.config.qmlls = default_config

			-- Enable Language Servers
			local servers = { "lua_ls", "clangd", "nil_ls", "qmlls" }
			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end

			-- Reload LSPs when direnv finishes evaluation
			vim.api.nvim_create_autocmd("User", {
				pattern = "DirenvLoaded",
				callback = function()
					for _, server in ipairs(servers) do
						-- Re-enable servers so they pick up binaries placed in $PATH by nix devShell
						vim.lsp.enable(server)
					end
				end,
			})

			-- Attach keybindings on LSP connection
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				end,
			})
		end,
	},

	-- Toggleable Terminal Plugin
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Floating Terminal" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=12<CR>", desc = "Toggle Horizontal Terminal" },
		},
		opts = {
			size = 12,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "horizontal", -- 'vertical' | 'ho erizontal' | 'tab' | 'float'
			close_on_exit = true,
			float_opts = {
				border = "curved",
				winblend = 0,
			},
		},
	},

	-- Project management
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- Methods used to detect the project root
				detection_methods = { "pattern" },
				-- Root markers (great for systems programming and git repos)
				patterns = { ".git", "Makefile", "compile_commands.json", "Cargo.toml", "package.json" },
			})

			-- Tell Telescope to load the projects extension
			require("telescope").load_extension("projects")
		end,
		keys = {
			-- Bind it to a hotkey, e.g., Space + f + p
			{ "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Find Projects" },
		},
	},

	-- Diagnostics for the code
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- Default configuration is usually perfect
		},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
		},
	},

	-- Auto-Format
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Manual format trigger (Space + f)
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			-- Map filetypes to formatters
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettier", "jq", stop_after_first = true },
				jsonc = { "prettier" },
			},
			-- Enable auto-format on save
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true, -- If no dedicated formatter is installed, use the LSP
			},
		},
	},

	-- Auto pairs (Bracket)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- 'config = true' is exactly equivalent to requiring and calling setup()
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- Automatically uses LSP / treesitter for code context
		},
	},
	-- Vertical indent lines & active scope highlighting
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "|", -- Character for regular indent lines
			},
			scope = {
				enabled = true,
				show_start = true, -- Highlight start line of scope
				show_end = true, -- Highlight end line of scope
				highlight = { "Function", "Label" },
			},
		},
	},

	-- Git Integration (Fugitive)
	{
		"tpope/vim-fugitive",
		--keys = {
		--{ "<leader>g", "<cmd>Git<CR>", desc = "Git Status (Fugitive)" },
		--},
	},

	-- Git Integration (Signs in gutter & branch detection)
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = false, -- Set to true if you want inline git blame text
		},
	},

	-- Statusline (Shows Git Branch, LSP diagnostics, file info)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight", -- Matches your installed colorscheme
					icons_enabled = true,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" }, -- 'branch' displays current git branch
					lualine_c = { { "filename", path = 1 } }, -- Shows relative file path
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
})
