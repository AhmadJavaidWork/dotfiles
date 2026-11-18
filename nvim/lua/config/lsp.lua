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
