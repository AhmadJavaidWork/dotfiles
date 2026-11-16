require("core.globals")
require("core.options")
require("core.keymaps")
require("config.lazy")
require("config.lsp")

require("nvim-tree").setup({
	view = {
		centralize_selection = false,
	},
	renderer = {
		highlight_git = "all",
		highlight_diagnostics = "all",
		highlight_modified = "all",
		highlight_hidden = "all",
	},
	update_focused_file = {
		enable = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			error = " ",
			hint = "󰠠 ",
			info = " ",
			warning = " ",
		},
	},
	modified = {
		enable = true,
		show_on_dirs = false,
	},
	filters = {
		git_ignored = false,
	},
	actions = {
		file_popup = {
			open_win_config = {
				border = "rounded",
			},
		},
	},
})
