local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local in_vscode = vim.g.vscode ~= nil
-- print("Is vscode: " .. tostring(in_vscode))

require("lazy").setup({
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		cond = not in_vscode,
	},
	{
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup({
				mappings = {
					comment = '<leader>/',
					comment_line = '<leader>/',
				}
			})
		end,
		cond = not in_vscode,
	}
})

local map = vim.keymap.set
if in_vscode then
	map('n', '<leader>/', '<Plug>VSCodeCommentaryLine')
	map('x', '<leader>/', '<Plug>VSCodeCommentary')

	map('n', '<leader>ff', ':Edit<CR>')
	map('n', '<leader>fs', [[<Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>]])
	
	map('n', '<leader>x', ':Quit<CR>')

	map({'n', 'x'}, '<S-h>', ':Tabprevious<CR>')
	map({'n', 'x'}, '<S-l>', ':Tabnext<CR>')
end
