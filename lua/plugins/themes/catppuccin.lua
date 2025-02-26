return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  flavour = "auto", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- desativa a configuração da cor de fundo.
  show_end_of_buffer = false, -- exibe os caracteres '~' após o final dos buffers
  term_colors = false, -- define as cores do terminal (ex: `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- escurece a cor de fundo da janela inativa
    shade = "dark",
    percentage = 0.15, -- porcentagem do sombreado a ser aplicado na janela inativa
  },
  no_italic = false, -- força a desativação do itálico
  no_bold = false, -- força a desativação do negrito
  no_underline = false, -- força a desativação do sublinhado
  styles = { -- Define os estilos dos grupos de destaque gerais (veja `:h highlight-args`):
    comments = { "italic" }, -- Altera o estilo dos comentários
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Descomente para desativar os estilos predefinidos
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- Para mais integrações com plugins, role para baixo (https://github.com/catppuccin/nvim#integrations)
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
