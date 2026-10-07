
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
