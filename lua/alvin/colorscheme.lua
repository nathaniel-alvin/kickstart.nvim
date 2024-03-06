return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa-dragon")
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
