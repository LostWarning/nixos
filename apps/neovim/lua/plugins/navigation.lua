local map = vim.keymap.set

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
