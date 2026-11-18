local set_keymap = vim.keymap.set

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = {
		source = false,
		prefix = "●",
	},
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		set_keymap("n", "K", function()
			vim.lsp.buf.hover()
		end, { desc = "LSP Hover Documentation" })

		set_keymap({ "i", "n" }, "<C-k>", function()
			vim.lsp.buf.signature_help()
		end, { buffer = ev.buf, silent = true, desc = "Open function signature help" })

		set_keymap("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, silent = true, desc = "Goto definition" })

		set_keymap(
			"n",
			"gr",
			vim.lsp.buf.references,
			{ buffer = ev.buf, silent = true, desc = "Open references in current buffer" }
		)

		set_keymap(
			"n",
			"<leader>rn",
			vim.lsp.buf.rename,
			{ buffer = ev.buf, silent = true, desc = "Rename a variable in scope" }
		)

		set_keymap(
			"n",
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ buffer = ev.buf, silent = true, desc = "Open available code action" }
		)

		set_keymap("n", "<leader>is", function()
			local client = vim.lsp.get_clients({ bufnr = ev.buf, method = "textDocument/hover" })[1]
			if not client then
				return vim.notify("No LSP hover support", vim.log.levels.WARN)
			end
			local row = vim.api.nvim_win_get_cursor(0)[1]
			local indent = vim.api.nvim_get_current_line():match("^%s*")
			local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
			client:request("textDocument/hover", params, function(err, result)
				if err or not result or not result.contents then
					return vim.notify("No signature found", vim.log.levels.WARN)
				end
				local sig, in_block = {}, false
				for _, line in ipairs(vim.lsp.util.convert_input_to_markdown_lines(result.contents)) do
					if line:match("^```") then
						if in_block then
							break
						end
						in_block = true
					elseif in_block then
						table.insert(sig, indent .. line)
					end
				end
				if #sig == 0 then
					return vim.notify("No signature found", vim.log.levels.WARN)
				end
				vim.api.nvim_buf_set_lines(ev.buf, row - 1, row - 1, false, sig)
			end, ev.buf)
		end, { buffer = ev.buf, silent = true, desc = "Insert signature of symbol under cursor above line" })

		set_keymap("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, silent = true, desc = "Goto declaration" })

		set_keymap(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			{ buffer = ev.buf, silent = true, desc = "Open implementations" }
		)

		set_keymap(
			"n",
			"gt",
			vim.lsp.buf.type_definition,
			{ buffer = ev.buf, silent = true, desc = "Goto type definition" }
		)

		set_keymap("n", "<leader>td", function()
			vim.diagnostic.enable(not vim.diagnostic.is_enabled())
		end, { desc = "Toggle lsp diagnostics" })

		set_keymap(
			"n",
			"<leader>ld",
			vim.diagnostic.open_float,
			{ buffer = ev.buf, silent = true, desc = "Open current line diagnostic in float" }
		)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if lang then
			pcall(vim.treesitter.start)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lspinfo,markdown,help",
	callback = function()
		set_keymap("n", "gd", function()
			vim.api.nvim_command("wincmd p")
			vim.lsp.buf.definition()
		end, { buffer = true, silent = true })

		set_keymap("n", "q", ":close<CR>", { buffer = true, silent = true })
	end,
})

set_keymap("n", "<C-space>", "v", { remap = true, desc = "Init selection" })
set_keymap("x", "<C-space>", "an", { remap = true, desc = "Increment selection" })
set_keymap("x", "<bs>", "in", { remap = true, desc = "Decrement selection" })
vim.treesitter.language.register("bash", "zsh")
