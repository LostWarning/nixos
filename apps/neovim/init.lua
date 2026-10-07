-- Ensure config directory is in runtimepath so lua modules can always be resolved
local current_file = debug.getinfo(1, "S").source:sub(2)
if current_file and current_file:match("^/") then
	local config_dir = vim.fn.fnamemodify(current_file, ":p:h")
	if not vim.tbl_contains(vim.opt.rtp:get(), config_dir) then
		vim.opt.rtp:prepend(config_dir)
	end
end

-- Core settings
require("core.options")
require("core.keymaps")

-- Plugins & Integrations
require("plugins.theme")
require("plugins.ui")
require("plugins.navigation")
require("plugins.treesitter")
require("plugins.formatting")
require("plugins.cmp")
require("plugins.lsp")
