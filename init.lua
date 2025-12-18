-- 1. Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- CONFIGURAÇÕES DE PERFORMANCE MÁXIMA
vim.opt.updatetime = 1000   -- Aumenta o tempo para disparar eventos (menos processamento)
vim.opt.lazyredraw = true   -- Não redesenha a tela enquanto executa macros
vim.opt.ttyfast = true      -- Indica conexão rápida
vim.opt.foldenable = false  -- Desativa dobras
vim.opt.cursorline = false  -- Desativa destaque da linha atual (pesado em scrolling)

require("lazy").setup({
  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        registries = { "github:mason-org/mason-registry", "github:Crashdummyy/mason-registry" },
      })
    end,
  },

  -- Roslyn (LSP) - APENAS AUTOCOMPLETE
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = { "williamboman/mason.nvim", "hrsh7th/cmp-nvim-lsp" },
    opts = {
      filewatching = "off", 
      config = {
        on_attach = function(client)
            -- MATA qualquer tentativa do Roslyn de pintar o código
            client.server_capabilities.semanticTokensProvider = nil
        end,
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = false,
            csharp_enable_inlay_hints_for_implicit_variable_types = false,
            dotnet_enable_inlay_hints_for_literal_parameters = false,
            dotnet_enable_inlay_hints_for_indexer_parameters = false,
          },
          ["csharp|background_analysis"] = {
             background_analysis = {
                dotnet_analyzer_diagnostics_scope = "none", -- Desativa análise de fundo total
                dotnet_compiler_diagnostics_scope = "openFiles",
             }
          }
        },
      },
    },
  },

  -- Treesitter (CONFIGURAÇÃO HÍBRIDA)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- REMOVI "razor" DAQUI para não usar o parser pesado
        ensure_installed = { "c_sharp", "html", "css", "lua" },
        
        highlight = { 
          enable = true,
          -- Desativa o Treesitter TOTALMENTE para Razor
          disable = { "razor" }, 
        },
        indent = { enable = false },
      })
    end,
  },

  -- Plugin Leve de Sintaxe (Substituto do Treesitter para Razor)
  { "adamclerk/vim-razor" },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        -- Aumentei o debounce para 150ms. O menu só aparece se você parar de digitar.
        performance = { debounce = 150, throttle = 60 },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' } }, { { name = 'buffer' } })
      })
    end,
  },
})

-- Força o plugin adamclerk/vim-razor a assumir
vim.filetype.add({ extension = { razor = "razor", cshtml = "razor" } })
