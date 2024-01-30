return {
	'rmagatti/auto-session',
	lazy = false,
	config = function()
		local autosession = require('auto-session')
		autosession.setup({
			auto_session_enable_last_session = true,
			auto_session_create_enabled = true,
			auto_save_enabled = true,
			auto_session_use_git_branch = true
		})
	end
}
