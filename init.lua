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
vim.g.maplocalleader = " "

local opt = vim.opt
local in_vscode = vim.g.vscode ~= nil
local map = vim.keymap.set

opt.clipboard = "unnamedplus" -- system clipboard

if not in_vs_code then
	opt.expandtab = true -- use spaces instead of tabs
	opt.shiftround = true -- round indent
	opt.shiftwidth = 2 -- size of indent
	opt.smartindent = true -- insert indents automatically
	opt.tabstop = 2 -- number of spaces a tab counts for
end

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
					comment = "<leader>/",
					comment_line = "<leader>/",
				},
			})
		end,
		cond = not in_vscode,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			local hop = require("hop")
			hop.setup()

			map("", "f", function()
				hop.hint_char1({ current_line_only = true })
			end, { remap = true })

			map("", "F", function()
				hop.hint_char1()
			end, { remap = true })
		end,
	},
})

if in_vscode then
	map("n", "<leader>/", "<Plug>VSCodeCommentaryLine")
	map("x", "<leader>/", "<Plug>VSCodeCommentary")

	map("n", "<leader>ff", ":Edit<CR>")
	map("n", "<leader>fs", [[<Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>]])

	map("n", "<leader>x", ":Quit<CR>")

	map({ "n", "x" }, "<S-h>", ":Tabprevious<CR>")
	map({ "n", "x" }, "<S-l>", ":Tabnext<CR>")
end
