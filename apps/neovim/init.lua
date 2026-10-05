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

-- Toggle fold at cursor (collapse / expand block)
map("n", "<Tab>", "za", { desc = "Toggle fold/collapse code block" })
map("n", "<leader>zc", "zM", { desc = "Collapse all code blocks" })
map("n", "<leader>zo", "zR", { desc = "Expand all code blocks" })

-- ============================================================================
-- 3. THEME & UI ENHANCEMENTS
-- ============================================================================
-- Tokyonight colorscheme
require("tokyonight").setup({
	style = "night",
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})
vim.cmd([[colorscheme tokyonight-night]])

-- Statusline (Lualine)
require("lualine").setup({
	options = {
		theme = "tokyonight",
		icons_enabled = true,
		component_separators = { left = "│", right = "│" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Breadcrumbs & Code Context (Barbecue + Navic)
require("barbecue").setup({})

-- Indent Guides (indent-blankline)
require("ibl").setup({
	indent = {
		char = "|",
	},
	scope = {
		enabled = true,
		show_start = true,
		show_end = true,
		highlight = { "Function", "Label" },
	},
})

-- Git Signs in Gutter
require("gitsigns").setup({
	current_line_blame = false,
})

-- Autopairs
require("nvim-autopairs").setup({})

-- ============================================================================
-- 4. NAVIGATION & WORKSPACE
-- ============================================================================
-- File Explorer (Neo-tree)
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
		},
	},
})
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle File Explorer" })

-- Fuzzy Finder (Telescope)
require("telescope").setup({})
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find Text (Grep)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help Tags" })

-- Project Management
local ok_project, project = pcall(require, "project")
if not ok_project then
	ok_project, project = pcall(require, "project_nvim")
end
if ok_project then
	project.setup({
		patterns = { ".git", "Makefile", "compile_commands.json", "Cargo.toml", "package.json" },
	})
	pcall(function()
		require("telescope").load_extension("projects")
	end)
end
map("n", "<leader>fp", "<Cmd>Telescope projects<CR>", { desc = "Find Projects" })

-- Toggleable Terminal (ToggleTerm)
require("toggleterm").setup({
	size = 12,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
	},
})
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Floating Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=12<CR>", { desc = "Toggle Horizontal Terminal" })

-- Diagnostics Viewer (Trouble)
require("trouble").setup({})
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })

-- ============================================================================
-- 5. SYNTAX HIGHLIGHTING (TREESITTER)
-- ============================================================================
-- Parsers are pre-compiled and managed declaratively by Nix.
require("nvim-treesitter").setup({})

-- Enable Treesitter syntax highlighting for buffers with available parsers
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- Enable Treesitter indentation
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(function()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end)
	end,
})

-- ============================================================================
-- 6. CODE FORMATTING (CONFORM)
-- ============================================================================
local conform = require("conform")
conform.setup({
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
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

map({ "n", "v" }, "<leader>f", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- ============================================================================
-- 7. AUTOCOMPLETION (NVIM-CMP)
-- ============================================================================
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

-- ============================================================================
-- 8. LANGUAGE SERVER PROTOCOL (LSP) & DIRENV
-- ============================================================================
vim.g.direnv_silent_load = 1

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_config = {
	capabilities = capabilities,
	root_markers = { "flake.nix", ".git", ".envrc" },
}

-- Server configs
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

vim.lsp.config.clangd = default_config
vim.lsp.config.rust_analyzer = default_config
vim.lsp.config.nil_ls = default_config
vim.lsp.config.qmlls = default_config

-- Enable servers
local servers = { "lua_ls", "clangd", "nil_ls", "qmlls", "rust_analyzer" }
for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

-- Reload LSPs when direnv finishes evaluation to pick up tools from nix devShells
vim.api.nvim_create_autocmd("User", {
	pattern = "DirenvLoaded",
	callback = function()
		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end
	end,
})

-- Attach LSP keybindings on connection
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
		map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
		map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find References" }))
		map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
		map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
	end,
})
