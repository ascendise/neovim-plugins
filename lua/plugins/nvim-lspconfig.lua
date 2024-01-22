return {
	{"neovim/nvim-lspconfig", 
		keys = {
			{ "gD", vim.lsp.buf.declaration }, 
			{ "gd", vim.lsp.buf.definition },
			{ "gi", vim.lsp.buf.implementation },
			{ "<C-k>", vim.lsp.buf.signature_help },
			{ "<leader>D", vim.lsp.buf.type_definitions },
			{ "<leader>rn", vim.lsp.buf.rename },
			{ "<leader>ca", vim.lsp.buf.code_action },
			{ "gr", vim.lsp.buf.references },
			{ "<leader>f", function()
				vim.lsp.buf.format { async = true }
				end 
			}
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup{}
		end
	}
}

