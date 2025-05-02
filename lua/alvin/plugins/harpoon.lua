return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    config = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon Add To List' })
      vim.keymap.set('n', '<C-s>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon Quick Menu' })
      vim.keymap.set('n', '<a-1>', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon Select [1]' })
      vim.keymap.set('n', '<a-2>', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon Select [2]' })
      vim.keymap.set('n', '<a-3>', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon Select [3]' })
      vim.keymap.set('n', '<a-4>', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon Select [4]' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<a-9>', function()
        harpoon:list():next()
      end)
      vim.keymap.set('n', '<a-8>', function()
        harpoon:list():prev()
      end)
    end,
  },
}
