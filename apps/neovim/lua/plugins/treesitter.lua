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
