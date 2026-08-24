return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
			'jay-babu/mason-nvim-dap.nvim',
		},
		config = function()
			local dap = require('dap')
			local dapui = require('dapui')

			require('mason-nvim-dap').setup({
				ensure_installed = { 'coreclr' },
				automatic_installation = true,
			})

			dapui.setup()

			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close

			dap.adapters.coreclr = {
				type = 'executable',
				command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
				args = { '--interpreter=vscode' },
			}

			dap.configurations.cs = {
				{
					type = 'coreclr',
					name = 'launch - netcoredbg',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/IronIndie.Crawl.Web/bin/Debug/net8.0/', 'file')
					end,
				},
			}

			vim.keymap.set('n', '<F5>', dap.continue)
			vim.keymap.set('n', '<leader>dq', dap.terminate)
			vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
			vim.keymap.set('n', '<leader>do', dap.step_over)
			vim.keymap.set('n', '<leader>di', dap.step_into)
			vim.keymap.set('n', '<leader>dO', dap.step_out)
			vim.keymap.set('n', '<leader>dr', dap.repl.open)
			vim.keymap.set({ 'n', 'v' }, '<leader>dh', function()
				require('dap.ui.widgets').hover()
			end)
		end,
	},
}
