return {
    'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup({
			pickers = {
				find_files = {
					hidden = true
				}
			}
		})
		local telescope = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
		vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
		vim.keymap.set('n', '<leader>ft', telescope.treesitter, {})
		vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
		vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
		vim.keymap.set('n', '<leader>fcs', telescope.colorscheme, {})
		vim.keymap.set('n', '<leader>fkm', telescope.keymaps, {})
		vim.keymap.set('n', '<leader>fds', telescope.lsp_document_symbols, {})
		vim.keymap.set('n', '<leader>fDs', telescope.lsp_workspace_symbols, {})
	end
}
