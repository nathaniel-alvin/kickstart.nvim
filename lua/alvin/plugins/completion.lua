return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Prettier icons
    'onsails/lspkind.nvim',

    -- Snippet Engine & its associated nvim-cmp source
    { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}
    local lspkind = require 'lspkind'
    lspkind.init {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { 'i', 'c' }
        ),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
      },
    }
    luasnip.config.set_config {
      history = false,
      updateevents = 'TextChanged,TextChangedI',
    }

    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/alvin/snippets/*.lua', true)) do
      loadfile(ft_path)()
    end

    vim.keymap.set({ 'i', 's' }, '<c-k>', function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<c-j>', function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })
  end,
}
