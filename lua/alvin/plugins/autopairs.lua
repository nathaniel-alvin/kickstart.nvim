-- return {
--   'windwp/nvim-autopairs',
--   event = 'InsertEnter',
--   config = function()
--     require('nvim-autopairs').setup {}
--     --   -- If you want to automatically add `(` after selecting a function or method
--     --   local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--     --   local cmp = require('cmp')
--     --   cmp.event:on(
--     --     'confirm_done',
--     --     cmp_autopairs.on_confirm_done()
--     --   )
--   end,
-- }

return {
  'altermo/ultimate-autopair.nvim',
  event = { 'InsertEnter', 'CmdlineEnter' },
  branch = 'v0.6',
  opts = {},
}
