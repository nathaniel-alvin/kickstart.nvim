return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        overrides = function(colors)
          local theme = colors.theme
          return {
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
      }
      )
      vim.cmd.colorscheme 'kanagawa-dragon'
    end,
  },
}

-- {
-- Theme inspired by Atom
--  'navarasu/onedark.nvim',
--  priority = 1000,
--  config = function()
--    vim.cmd.colorscheme 'onedark'
--  end,
--},

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
