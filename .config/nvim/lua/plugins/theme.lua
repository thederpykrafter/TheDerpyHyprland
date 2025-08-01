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
    custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
    custom_palette = {} or function(palette) return {} end, -- extend palette
    terminal_colors = true, -- enable terminal colors
  },
  config = function(_, opts)
    require('tokyodark').setup(opts) -- calling setup is optional
    vim.cmd [[colorscheme tokyodark]]
  end,
}

local pywal = {
  'uZer/pywal16.nvim',
  -- for local dev replace with:
  -- dir = '~/your/path/pywal16.nvim',
  config = function() vim.cmd.colorscheme('pywal16') end,
}

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

if not file_exists('/home/thederpykrafter/.cache/wal') then
  return tokyodark
else
  return { pywal }
end
