-- Priority Ranges
-- [1000] Colortheme
	-- folke/tokyonight
-- [900-999] Libraries / Utility
	-- 999 plenary.nvim
-- [800-899] LSP
	-- 899 folke/neodev
	-- 898 mfussenegger/nvim-dap 
	-- 897 rcarriga/nvim-dap-ui
	-- 800 neovim/nvim-lspconfig
-- [0 - 799] To Be Defined

-- General Vim Config
vim.g.mapleader = ',' 
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.number = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.cmd[[colorscheme tokyonight-night]]

