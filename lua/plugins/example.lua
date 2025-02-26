-- como este é apenas um exemplo de especificação, não carregue nada aqui e retorne uma especificação vazia
-- stylua: ignore
if true then return {} end

-- cada arquivo de especificação dentro do diretório "plugins" será carregado automaticamente pelo lazy.nvim
--
-- Nos seus arquivos de plugins, você pode:
-- * adicionar plugins extras
-- * desabilitar/habilitar plugins do LazyVim
-- * sobrescrever a configuração dos plugins do LazyVim
return {
  -- adicionar gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configurar o LazyVim para carregar o gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- alterar a configuração do trouble
  {
    "folke/trouble.nvim",
    -- as opções serão mescladas com a especificação principal
    opts = { use_diagnostic_signs = true },
  },

  -- desabilitar trouble
  { "folke/trouble.nvim", enabled = false },

  -- sobrescrever nvim-cmp e adicionar cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- alterar algumas opções do telescope e um atalho para navegar pelos arquivos de plugins
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- adicionar um atalho para navegar pelos arquivos de plugins
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Encontrar Arquivo de Plugin",
      },
    },
    -- alterar algumas opções
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- adicionar pyright ao lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- o pyright será instalado automaticamente com o mason e carregado com o lspconfig
        pyright = {},
      },
    },
  },

  -- adicionar tsserver e configurá-lo com typescript.nvim em vez do lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organizar Importações" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Renomear Arquivo", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- o tsserver será instalado automaticamente com o mason e carregado com o lspconfig
        tsserver = {},
      },
      -- você pode fazer qualquer configuração adicional do servidor lsp aqui
      -- retorne true se você não quiser que este servidor seja configurado com lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- exemplo de configuração com typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Especifique * para usar esta função como um fallback para qualquer servidor
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- para typescript, o LazyVim também inclui especificações extras para configurar corretamente lspconfig,
  -- treesitter, mason e typescript.nvim. Então, em vez do código acima, você pode usar:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- adicionar mais parsers para treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- como `vim.tbl_deep_extend` pode apenas mesclar tabelas e não listas, o código acima
  -- sobrescreveria `ensure_installed` com o novo valor.
  -- Se você preferir estender a configuração padrão, use o código abaixo:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- adicionar tsx e typescript ao treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- a função opts também pode ser usada para alterar as opções padrão:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- ou você pode retornar novas opções para sobrescrever todas as opções padrão
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[adicione sua configuração personalizada do lualine aqui]]
      }
    end,
  },

  -- usar mini.starter em vez de alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- adicionar pacotes jsonls e schemastore e configurar treesitter para json, json5 e jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- adicione abaixo quaisquer ferramentas que você deseja instalar
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
