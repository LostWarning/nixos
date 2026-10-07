local map = vim.keymap.set

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
