return {
  {
    'folke/snacks.nvim',
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
      {
        '<leader>lg',
        function()
          Snacks.lazygit.open(opts)
        end,
        desc = 'Lazy Git',
      },
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>ds',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>ws',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
    },
    opts = {
      bigfile = { enabled = true },
      indent = {
        enabled = true,
        char = '│',
        animate = { enabled = false },
        indent = {
          only_current = true,
          only_scope = true,
        },
        scope = {
          enabled = true,
          only_current = true,
          only_scope = true,
          underline = false,
        },
        chunk = {
          enabled = true,
          only_current = true,
        },
        filter = function(buf)
          local exclude_ft = {
            help = true,
            git = true,
            markdown = true,
            snippets = true,
            text = true,
            gitconfig = true,
            alpha = true,
            dashboard = true,
          }

          local ft = vim.bo[buf].filetype
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == '' and not exclude_ft[ft]
        end,
      },
      notifier = {
        enabled = true,
        top_down = false,
        win = {
          backdrop = {
            transparent = false,
          },
        },
      },
      picker = {
        enabled = true,
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            exclude = { 'package-lock.json', 'lazy-lock.json' },
          },
        },
        -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
        -- file was always showing at the top, I needed a way to decrease its
        -- score, in frecency you could use :FrecencyDelete to delete a file
        -- from the database, here you can decrease it's score
        -- transform = function(item)
        --   if not item.file then
        --     return item
        --   end
        --   -- Demote the "lazyvim" keymaps file:
        --   if item.file:match 'lazyvim/lua/config/keymaps%.lua' then
        --     item.score_add = (item.score_add or 0) - 30
        --   end
        --   -- Boost the "neobean" keymaps file:
        --   -- if item.file:match("neobean/lua/config/keymaps%.lua") then
        --   --   item.score_add = (item.score_add or 0) + 100
        --   -- end
        --   return item
        -- end,
        -- In case you want to make sure that the score manipulation above works
        -- or if you want to check the score of each file
        debug = {
          scores = false, -- show scores in the list
        },
        -- I like the "ivy" layout, so I set it as the default globaly, you can
        -- still override it in different keymaps
        layout = {
          preset = 'ivy',
          -- When reaching the bottom of the results in the picker, I don't want
          -- it to cycle and go back to the top
          cycle = false,
        },
        layouts = {
          -- I wanted to modify the ivy layout height and preview pane width,
          -- this is the only way I was able to do it
          -- NOTE: I don't think this is the right way as I'm declaring all the
          -- other values below, if you know a better way, let me know
          --
          -- Then call this layout in the keymaps above
          -- got example from here
          -- https://github.com/folke/snacks.nvim/discussions/468
          ivy = {
            layout = {
              box = 'vertical',
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = 'top',
              title = ' {title} {live} {flags}',
              title_pos = 'left',
              { win = 'input', height = 1, border = 'bottom' },
              {
                box = 'horizontal',
                { win = 'list', border = 'none' },
                { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
              },
            },
          },
          -- I wanted to modify the layout width
          --
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = 'vertical',
              border = 'rounded',
              title = '{title} {live} {flags}',
              title_pos = 'center',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
              { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            },
          },
        },
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
            truncate = 80,
          },
        },
        lazy = false,
        dependencies = {
          { 'nvim-lua/plenary.nvim' },
        },
      },
      lazygit = {
        theme = {
          selectedLineBgColor = { bg = 'CursorLine' },
        },
        win = {
          width = 0,
          height = 0,
        },
      },
      styles = {
        zen = {
          backdrop = {
            transparent = false,
          },
          width = 100,
          wo = {
            number = false,
            signcolumn = 'no',
            cursorcolumn = false,
            relativenumber = false,
          },
        },
        notification = {
          wo = {
            spell = false,
            winblend = 0,
          },
        },
      },
    },
  },
}
