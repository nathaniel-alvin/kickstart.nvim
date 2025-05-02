return {
  {
    'folke/snacks.nvim',
    opts = {
      picker = {},
    },
    keys = {
      {
        '<leader>sf',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader><space>',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
    },
  },
}
