-- Parsers are pre-compiled and managed declaratively by Nix.
require("nvim-treesitter").setup({})

-- Enable Treesitter syntax highlighting for buffers with available parsers
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- Enable Treesitter indentation (leave C/C++ to native cindent)
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft ~= "c" and ft ~= "cpp" then
			pcall(function()
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end)
		end
	end,
})
