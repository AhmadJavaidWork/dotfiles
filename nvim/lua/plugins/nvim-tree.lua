return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Nvim tree" })
	end,
}
