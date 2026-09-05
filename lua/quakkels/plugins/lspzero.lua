return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{'L3MON4D3/LuaSnip'},
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require('cmp')
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup({
				formatting = lsp_zero.cmp_format({details = true}),
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-f>'] = cmp_action.luasnip_jump_forward(),
					['<C-b>'] = cmp_action.luasnip_jump_backward(),
					['<CR>'] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),
				}),
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
			})
		end
	},

	-- LSP
	{
		'neovim/nvim-lspconfig',
		cmd = {'LspInfo', 'LspInstall', 'LspStart'},
		event = {'BufReadPre', 'BufNewFile'},
		dependencies = {
			{'hrsh7th/cmp-nvim-lsp'},
			{'williamboman/mason-lspconfig.nvim'},
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			--- if you want to know more about lsp-zero and mason.nvim
			--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({buffer = bufnr})

				local builtin = require('telescope.builtin')
				local opts = {buffer = bufnr}

				-- anything that returns a list goes through telescope
				vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
				vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
				vim.keymap.set('n', 'go', builtin.lsp_type_definitions, opts)
				vim.keymap.set('n', 'grr', builtin.lsp_references, opts)
				vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, opts)

				vim.keymap.set('n', '<leader>vrr', builtin.lsp_references, opts)
				vim.keymap.set('n', '<leader>vws', builtin.lsp_dynamic_workspace_symbols, opts)
				vim.keymap.set('n', '<leader>vs', builtin.lsp_document_symbols, opts)
				vim.keymap.set('n', '<leader>vD', builtin.diagnostics, opts)

				-- single actions stay on the raw lsp functions
				vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
				vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
				vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
			end)

			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,

					-- this is the "custom handler" for `lua_ls`
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls()
						require('lspconfig').lua_ls.setup(lua_opts)
					end,

					-- roslyn.nvim manages the C# LSP client itself; skip the default
					-- handler so omnisharp (if still installed via mason) doesn't
					-- also attach and fight over the same buffers.
					omnisharp = function() end,
				}
			})
		end
	}
}
