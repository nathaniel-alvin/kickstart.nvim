return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa-dragon'
    end,
    config = function()
      require('kanagawa').setup {
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
      }
    end,
  },
}
-- {
--   'ramojus/mellifluous.nvim',
--   priority = 1000,
--   init = function()
--     require 'mellifluous'.setup({
--       color_set = 'kanagawa_dragon'
--     })
--     vim.cmd.colorscheme 'mellifluous'
--   end,
-- }
-- {
-- Theme inspired by Atom
--  'navarasu/onedark.nvim',
--  priority = 1000,
--  config = function()
--    vim.cmd.colorscheme 'onedark'
--  end,
-- },

-- {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'catppuccin'
--   end,
-- },
-- {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   config = function()
--     require("catppuccin").setup({
--       term_colors = true,
--       transparent_background = false,
--       styles = {
--         comments = {},
--         conditionals = {},
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--       },
--       color_overrides = {
--         mocha = {
--           base = "#000000",
--           mantle = "#000000",
--           crust = "#000000",
--         },
--       },
--       integrations = {
--         telescope = {
--           enabled = true,
--           -- style = "nvchad",
--         },
--       },
--     })
--     vim.cmd.colorscheme 'catppuccin-mocha'
--   end,
-- },
