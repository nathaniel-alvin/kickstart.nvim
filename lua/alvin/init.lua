-- [[ Configure plugins ]]
require('lazy').setup({

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    'folke/todo-comments.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      {
        ']t',
        mode = { 'n' },
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        mode = { 'n' },
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
    },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      -- library = {
      --   -- See the configuration section for more details
      --   -- Load luvit types when the `vim.uv` word is found
      --   { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },

  -- collection of mini.nvim
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Mini statusline
      local statusline = require 'mini.statusline'
      statusline.setup()

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Mini ai
      local miniai = require 'mini.ai'
      miniai.setup()

      -- Mini comment
      local minicomment = require 'mini.comment'
      minicomment.setup()
    end,
  },

  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
  },
  -- require 'kickstart.plugins.autoformat',

  { import = 'alvin.plugins' },
}, {})

require 'alvin.remap'

-- [[ Highlight on yank ]]
--  Highlight when yanking text

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Define a function to remove carriage return characters
local function remove_carriage_returns()
  vim.api.nvim_command '%s/\\r//g'
end

-- Create a custom command 'Slinefeed' that calls the function
vim.api.nvim_create_user_command('Slinefeed', remove_carriage_returns, {})
