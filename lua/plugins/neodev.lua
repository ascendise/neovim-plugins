return {
	"folke/neodev.nvim",
	priority = 899,
	config = function()  
		local neodev = require('neodev')
		neodev.setup({
			library = {
				plugins = { "nvim-dap-ui" },
				types = true
			}
		})
	end
}


