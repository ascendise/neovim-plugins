local function luaLsSetup()
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

local function omnisharpSetup()
	return {
		cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
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
			lspconfig.omnisharp.setup(omnisharpSetup())
		end
	}
}
