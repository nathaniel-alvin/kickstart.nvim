return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/neodev.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    require('neodev').setup {
      -- library = {
      --   plugins = { "nvim-dap-ui" },
      --   types = true,
      -- },
    }

    local capabilities = nil
    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = require('cmp_nvim_lsp').default_capabilities()
    end

    local lspconfig = require 'lspconfig'

    local servers = {
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
              fieldalignment = true,
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
    }

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == 'table' then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    require('mason').setup()
    local ensure_installed = {
      'stylua',
      'lua_ls',
      'delve',
      'prettier',
      'hadolint',
      'phpcs',
      'php-cs-fixer',
      -- "tailwind-language-server",
    }

    vim.list_extend(ensure_installed, servers_to_install)
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend('force', {}, {
        capabilities = capabilities,
      }, config)

      if name == 'tsserver' then
        name = 'ts_ls'
      end
      lspconfig[name].setup(config)
    end

    -- example for further config for specific LSP
    -- lspconfig.lua_ls.setup({
    --   capabilities = capabilities,
    -- })

    local disable_semantic_tokens = {
      lua = true,
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), 'must have valid client')

        local settings = servers[client.name]
        if type(settings) ~= 'table' then
          settings = {}
        end

        local builtin = require 'telescope.builtin'

        vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = 0 })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set('n', 'gI', builtin.lsp_implementations, { buffer = 0 })
        vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = 0 })

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
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
      end,
    })
  end,
}
