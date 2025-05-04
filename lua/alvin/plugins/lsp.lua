return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    { 'j-hui/fidget.nvim', opts = {} },
  },
  opts = {
    ensure_installed = {
      'stylua',
      'lua_ls',
      'delve',
      'prettier',
      'hadolint',
      'phpcs',
      'php-cs-fixer',
      -- "tailwind-language-server",
    },
    servers = {
      -- clangd = {},
      gopls = {
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
            semanticTokens = true,
          },
        },
      },

      html = { filetypes = { 'html', 'tmpl', 'twig', 'hbs' } },
      htmx = { filetypes = { 'html', 'tmpl' } },
      tailwindcss = {
        filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
        init_options = { userLanguages = { templ = 'html' } },
      },

      lua_ls = {
        server_capabilities = {
          semanticTokensProvider = vim.NIL,
        },
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      svelte = true,
      cssls = true,
      templ = true,
      -- tsserver = {
      --   enabled = false,
      -- },
      vtsls = {
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },
      pyright = true,
      -- basedpyright = {
      --   settings = {
      --     pyright = {
      --       disableOrganizeImports = true,
      --     },
      --     python = {
      --       analysis = {
      --         ignore = { '*' },
      --         typeCheckingMode = 'standard',
      --       },
      --     },
      --   },
      -- },
      -- ruff = true,
      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        -- Have to add this for yamlls to understand that we support line folding
        -- capabilities = {
        --   textDocument = {
        --     foldingRange = {
        --       dynamicRegistration = false,
        --       lineFoldingOnly = true,
        --     },
        --   },
        -- },
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
        end,
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = '',
            },
          },
        },
      },
      emmet_ls = {
        enabled = false,
        filetypes = {
          'html',
          'typescriptreact',
          'javascriptreact',
          'css',
          'sass',
          'scss',
          'less',
          'svelte',
        },
      },
      dockerls = {},
      docker_compose_language_service = {},
      phpactor = {
        enabled = true,
      },
      intelephense = {
        enabled = true,
      },
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
    },
    disable_semantic_tokens = {
      lua = true,
    },
  },

  config = function(_, opts)
    local lspconfig = require 'lspconfig'
    local mason = require 'mason'
    local mason_tool_installer = require 'mason-tool-installer'
    local cmp = require 'blink.cmp'

    local capabilities = cmp.get_lsp_capabilities and cmp.get_lsp_capabilities() or cmp.default_capabilities()

    -- adds all the servers names in the server table and add them to servers to install
    -- to exclude:
    -- html = { manual_install = true } -- explicitly opted out of auto-install
    --jsonls = false -- falsy value
    local servers_to_install = vim.tbl_filter(function(key)
      local t = opts.servers[key]
      if type(t) == 'table' then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(opts.servers))

    vim.list_extend(opts.ensure_installed, servers_to_install)

    mason.setup()
    mason_tool_installer.setup { ensure_installed = opts.ensure_installed }

    for name, config in pairs(opts.servers) do
      if config == true then
        config = {}
      end
      -- config = vim.tbl_deep_extend('force', {}, {
      --   capabilities = capabilities,
      -- }, config)
      config.capabilities = capabilities

      if name == 'tsserver' then
        name = 'ts_ls'
      end
      lspconfig[name].setup(config)
    end

    -- example for further config for specific LSP
    -- lspconfig.lua_ls.setup({
    --   capabilities = capabilities,
    -- })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id), 'must have valid client')

        -- local settings = servers[client.name]
        -- if type(settings) ~= 'table' then
        --   settings = {}
        -- end
        local settings = opts.servers[client.name] or {}

        vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set({ 'n', 'x' }, '<space>ca', vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })

        if opts.disable_semantic_tokens[vim.bo[bufnr].filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Override server capabilities
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, { bufnr = bufnr }) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })
  end,
}
