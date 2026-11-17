return {
	"mistricky/codesnap.nvim",
	tag = "v2.1.1",
	config = function()
		require("codesnap").setup({
			snapshot_config = {
				watermark = {
					content = "",
				},
				background = "#1e1e2e",
			},
		})
	end,
}
