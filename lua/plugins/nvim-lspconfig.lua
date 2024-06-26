function luaLsSetup()
	return {
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
				client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT'
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							}
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						}
					}
				})

				client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
			end
			return true
		end
	}
end

return {
	{
		"neovim/nvim-lspconfig",
		keys = {
			{ "gD",         vim.lsp.buf.declaration },
			{ "gd",         vim.lsp.buf.definition },
			{ "K",          vim.lsp.buf.hover },
			{ "gi",         vim.lsp.buf.implementation },
			{ "<C-k>",      vim.lsp.buf.signature_help },
			{ "<leader>D",  vim.lsp.buf.type_definitions },
			{ "<leader>rn", vim.lsp.buf.rename },
			{ "<leader>ca", vim.lsp.buf.code_action },
			{ "gr",         vim.lsp.buf.references },
			{ "<leader>f", function()
				vim.lsp.buf.format { async = true }
			end
			}
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({})
			lspconfig.lua_ls.setup(luaLsSetup())
			lspconfig.cmake.setup({})
		end
	}
}
