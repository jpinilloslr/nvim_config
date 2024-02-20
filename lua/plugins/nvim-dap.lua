return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      -- Set keymaps to control the debugger
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F6>', dap.step_over)
      vim.keymap.set('n', '<F7>', dap.step_into)
      vim.keymap.set('n', '<F8>', dap.step_out)
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = '[D]ebug Toggle [B]reakpoint With Condition' })

      local js_based_languages = { 'typescript', 'javascript', 'typescriptreact' }

      for _, language in ipairs(js_based_languages) do
        require('dap').configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require 'dap.utils'.pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Start Chrome with "localhost"',
            url = 'http://localhost:3000',
            webRoot = '${workspaceFolder}',
            userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir'
          }
        }
      end
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
      local dap, dapui = require('dap'), require('dapui')

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close({})
      end

      vim.keymap.set('n', '<leader>du', require 'dapui'.toggle, { desc = '[D]ebug Toggle [U]I' })
    end
  },
  {
    -- JS debugger
    'microsoft/vscode-js-debug',
    build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out'
  },
  {
    -- JS adapters
    'mxsdev/nvim-dap-vscode-js',
    config = function()
      require('dap-vscode-js').setup({
        debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
        adapters = {
          'chrome',
          'pwa-node',
          'pwa-chrome',
          'pwa-msedge',
          'node-terminal',
          'pwa-extensionHost',
          'node',
          'chrome'
        },
      })
    end
  },
}
