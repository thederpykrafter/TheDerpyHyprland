local tokyodark = {
  'tiagovla/tokyodark.nvim',
  opts = {
    transparent_background = true, -- set background to transparent
    gamma = 1.00, -- adjust the brightness of the theme
    styles = {
      comments = { italic = true }, -- style for comments
      keywords = { italic = true }, -- style for keywords
      identifiers = { italic = true }, -- style for identifiers
      functions = {}, -- style for functions
      variables = {}, -- style for variables
    },
    ---@diagnostic disable-next-line: unused-local
    custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
    ---@diagnostic disable-next-line: unused-local
    custom_palette = {} or function(palette) return {} end, -- extend palette
    terminal_colors = true, -- enable terminal colors
  },
  config = function(_, opts)
    require('tokyodark').setup(opts) -- calling setup is optional
    require('markview.extras.checkboxes').setup()
    vim.cmd [[colorscheme tokyodark]]
    vim.cmd('highlight MarkviewCode guibg=#11121D')
    vim.cmd('highlight MarkviewInlineCode guibg=#11121D')
  end,
}

local pywal = {
  'uZer/pywal16.nvim',
  -- for local dev replace with:
  -- dir = '~/your/path/pywal16.nvim',
  config = function() vim.cmd.colorscheme('pywal16') end,
}

return tokyodark
