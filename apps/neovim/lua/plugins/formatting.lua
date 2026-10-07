local map = vim.keymap.set
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
