return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				zig = { "zigfmt" },
				go = { "gofmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				["_"] = { "trim_whitespace" },
			},

			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>fs", function()
			conform.format({
				lsp_fallback = true,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range" })

		vim.keymap.set("n", "<leader>lf", function()
			local lines = { "Formatters for " .. vim.bo.filetype .. ":" }
			for _, f in ipairs(conform.list_formatters_for_buffer()) do
				local info = conform.get_formatter_info(f)
				local line = (info.available and "[x] " or "[ ] ") .. f
				if not info.available then
					line = line .. "  (" .. info.available_msg .. ")"
				end
				table.insert(lines, line)
			end
			vim.notify(table.concat(lines, "\n"))
		end, { desc = "List formatters for current buffer" })
	end,
}
