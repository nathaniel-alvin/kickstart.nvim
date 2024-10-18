return {
  'folke/trouble.nvim',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  opts = { -- for default options, refer to the configuration section for custom setup.
    focus = true,
    -- Create an autocommand that triggers on the BufRead and BufNewFile events for Trouble buffers
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'BufNewFile' }, {
      pattern = '*',
      callback = function()
        if vim.bo.filetype == 'trouble' then
          -- Set the wrap option for the buffer
          vim.wo.wrap = true
          vim.wo.colorcolumn = ''
        end
      end,
    }),
  },
}

-- -- trouble.nvim
-- vim.keymap.set('n', '<leader>xx', function()
--   require('trouble').toggle()
-- end, { desc = 'Open diagnostics list' })
-- vim.keymap.set('n', '<leader>xw', function()
--   require('trouble').toggle 'workspace_diagnostics'
-- end, { desc = 'Open [w]rkspace diagnostics list' })
-- vim.keymap.set('n', '<leader>xd', function()
--   require('trouble').toggle 'document_diagnostics'
-- end, { desc = 'Open [d]ocument diagnostics list' })
-- vim.keymap.set('n', '<leader>xn', function()
--   require('trouble').next { skip_groups = true, jump = true }
-- end, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>xp', function()
--   require('trouble').previous { skip_groups = true, jump = true }
-- end, { desc = 'Go to previous diagnostic message' })
