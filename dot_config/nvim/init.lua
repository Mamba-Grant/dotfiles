vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

-- For options & keymappings & coloring
require("core")

-- Install the Lazy Plugins Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

-- Where you can intall and modify your plugins
require("plugins")
-- Highlighting
require("core.hi")

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = vim.api.nvim_create_augroup("Format", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("undojoin")
-- 		vim.cmd("Neoformat")
-- 	end,
-- })

-- vim.cmd([[
--   augroup Format
--     autocmd!
--     autocmd BufWritePre * undojoin | Neoformat
--   augroup end
-- ]])

vim.g.neoformat_basic_format_align = 1
vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_basic_format_trim = 1

vim.g.vimtex_view_method = "zathura"
vim.api.nvim_set_keymap("n", "<Leader>ll", ":VimtexCompile<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", { silent = true })
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { silent = true })

local ls = require("luasnip")
vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
