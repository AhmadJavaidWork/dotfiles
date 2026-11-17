return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.2",
	dependencies = { "nvim-lua/plenary.nvim", { "nvim-treesitter/nvim-treesitter", branch = "master" } },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		telescope.setup({
			defaults = {
				layout_strategy = "flex",
			},
		})

		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files(themes.get_dropdown({
				previewer = false,
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--no-ignore",
					"--glob",
					"!**/.git/**",
					"--glob",
					"!**/node_modules/**",
					"--glob",
					"!**/dist/**",
					"--glob",
					"!**/.next/**",
					"--glob",
					"!**/.dart_tool/**",
					"--glob",
					"!**/.venv/**",
					"--glob",
					"!**/build/**",
					"--glob",
					"!**/gradle/**",
					"--glob",
					"!**/__pycache__/**",
					"--glob",
					"!**/graphify-out/**",
					"--glob",
					"!**/.terraform/**",
					"--glob",
					"!**/.zig-cache/**",
					"--glob",
					"!**/zig-out/**",
				},
			}))
		end, { desc = "Telescope find files" })

		vim.keymap.set("n", "<leader>gi", function()
			builtin.live_grep({
				additional_args = function()
					return { "--hidden" }
				end,
				glob_pattern = {
					"!**/.git/**",
					"!**/node_modules/**",
					"!**/dist/**",
					"!**/.next/**",
					"!**/.dart_tool/**",
					"!**/.venv/**",
					"!**/build/**",
					"!**/gradle/**",
					"!**/__pycache__/**",
					"!**/graphify-out/**",
					"!**/.terraform/**",
					"!**/.zig-cache/**",
					"!**/zig-out/**",
				},
			})
		end, { desc = "Telescope live grep" })

		vim.keymap.set("n", "<leader>gs", builtin.grep_string, { desc = "Telescope grep string" })
		vim.keymap.set("n", "<leader>tt", builtin.treesitter, { desc = "Telescope treesitter" })

		vim.keymap.set("n", "<leader>ps", builtin.git_status, { desc = "Telescope git status" })

		vim.keymap.set("n", "<leader>cs", function()
			builtin.colorscheme({
				enable_preview = true,
			})
		end, { desc = "Telescope colorscheme" })

		vim.keymap.set("n", "<leader>pb", function()
			builtin.buffers({
				sort_mru = true,
				file_ignore_patterns = {
					"/node_modules/",
					"node_modules/",
					"/dist/",
					"dist/",
					".next/",
					"/.next/",
					".dart_tool/",
					"/.dart_tool/",
					".venv/",
					"/.venv/",
					"build/",
					"/build/",
					"gradle/",
					"/gradle/",
					"__pycache__/",
					"/__pycache__/",
					"graphify-out/",
					"/graphify-out/",
					".terraform/",
					"/.terraform/",
					".zig-cache/",
					"/.zig-cache/",
					"zig-out/",
					"/zig-out/",
				},
			})
		end, { desc = "Telescope open buffers" })

		vim.keymap.set("n", "<leader>pc", function()
			builtin.git_commits()
		end, { desc = "Telescope commits" })

		vim.keymap.set("n", "<leader>man", function()
			builtin.man_pages({ sections = { "ALL" } })
		end, { desc = "Telescope system man pages" })

		vim.keymap.set("n", "<leader>pa", function()
			builtin.find_files({
				no_ignore = true,
				hidden = true,
				file_ignore_patterns = {
					"^node_modules/",
					"^.git/",
					"target/",
					"dist/",
				},
			})
		end, { desc = "Telescope find all files" })

		vim.keymap.set(
			"n",
			"<leader>ds",
			builtin.lsp_document_symbols,
			{ desc = "Telescope search document symbol in current buffer" }
		)

		vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "Telescope current symbol lsp references" })
	end,
}
